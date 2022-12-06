//
//  ChoreCardViewModel.swift
//  Dobby
//
//  Created by yongmin lee on 11/13/22.
//

import Foundation
import RxSwift
import RxCocoa

class ChoreCardViewModel: BaseViewModel {
    
    // MARK: property
    let isGroupChore: Bool
    let dateList: [Date]
    let userUseCase: UserUseCase
    let groupUseCase: GroupUseCase
    let choreUseCase: ChoreUseCase
    
    let memberListBehavior: BehaviorRelay<[User]> = .init(value: [])
    let choreListBehavior: BehaviorRelay<[[Chore]]> = .init(value: [])
    let isChoreListEmptyBehavior: BehaviorRelay<Bool> = .init(value: true)
    
    // MARK: initialize
    init(
        dateList: [Date],
        isGroupChore: Bool,
        userUseCase: UserUseCase,
        groupUseCase: GroupUseCase,
        choreUseCase: ChoreUseCase
    ) {
        self.isGroupChore = isGroupChore
        self.dateList = dateList
        self.userUseCase = userUseCase
        self.groupUseCase = groupUseCase
        self.choreUseCase = choreUseCase
    }
    
    func getMemberList() {
        self.loadingPublish.accept(true)
        self.userUseCase.getMyInfo()
            .flatMapLatest { [unowned self] myinfo -> Observable<Group> in
                if self.isGroupChore {
                    guard let userId = myinfo.userId else {return .error(CustomError.init())}
                    return self.groupUseCase.getGroupInfo(id: userId)
                } else {
                    self.memberListBehavior.accept([myinfo])
//                    self.loadingPublish.accept(false)
                    return .empty()
                }
            }
            .subscribe(onNext: { [weak self] group in
                guard let members = group.memberList else {return}
                self?.memberListBehavior.accept(members)
//                self?.loadingPublish.accept(false)
            }, onError: { [weak self] _ in
                self?.loadingPublish.accept(false)
            }).disposed(by: self.disposBag)
    }
    
    func getChoreList(of members: [User]) {
        var observableList: [Observable<[Chore]>] = .init()
        
        dateList.forEach {  date in
            members.forEach { member in
                let observable = self.choreUseCase.getChores(
                    userId: member.userId!,
                    groupId: member.groupList!.last!.groupId!,
                    date: date,
                    periodical: .daily
                )
                observableList.append(observable)
            }
        }
        Observable.zip(observableList)
            .subscribe(onNext: { [weak self] choreList in
                if choreList.isEmpty {
                    self?.choreListBehavior.accept([])
                    self?.isChoreListEmptyBehavior.accept(true)
                }
                else if let firstChore = choreList.first, firstChore.isEmpty {
                    self?.choreListBehavior.accept([])
                    self?.isChoreListEmptyBehavior.accept(true)
                } else {
                    self?.choreListBehavior.accept(choreList)
                    self?.isChoreListEmptyBehavior.accept(false)
                }
                self?.loadingPublish.accept(false)
            }, onError: { [weak self] _ in
                self?.choreListBehavior.accept([])
                self?.isChoreListEmptyBehavior.accept(true)
                self?.loadingPublish.accept(false)
            }).disposed(by: self.disposBag)
    }
}
