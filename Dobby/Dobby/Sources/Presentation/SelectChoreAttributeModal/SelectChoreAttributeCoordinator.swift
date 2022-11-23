//
//  SelectChoreAttributeCoordinator.swift
//  Dobby
//
//  Created by yongmin lee on 10/29/22.
//

import Foundation

final class SelectChoreAttributeCoordinator: ModalCoordinator {
    
    convenience init(
        choreAttribute: ChoreAttribute,
        viewModel: AddChoreViewModel,
        parentCoordinator: Coordinator? = nil,
        childCoordinators: [Coordinator] = []
    ) {
        self.init(parentCoordinator: parentCoordinator, childCoordinators: childCoordinators)
        let contentView = self.selectChoreAttributeFactory(
            attribute: choreAttribute,
            viewModel: viewModel
        )
        let viewController = SelectChoreAttributeViewController(
            coordinator: self,
            viewModel: viewModel,
            contentView: contentView
        )
        viewController.modalPresentationStyle = .overFullScreen
        self.viewController = viewController
    }
    
    func selectChoreAttributeFactory(
        attribute: ChoreAttribute,
        viewModel: AddChoreViewModel
    ) -> ModalContentView {
        switch attribute {
        case .startDate:
            return SelectDateView(attribute: attribute)
        case .repeatCycle:
            return SelectRepeatCycleView(
                attribute: attribute, repeatCycleList: viewModel.repeatCycleList
            )
        case .category:
            return SelectCategoryView(
                attribute: attribute,
                categoryList: viewModel.categoriesBehavior.value
            )
        case .owner:
            return SelectDateView(attribute: attribute)
        case .memo:
            return SelectDateView(attribute: attribute)
        }
    }
}
