//
//  PolicyType.swift
//  Dobby
//
//  Created by yongmin lee on 11/29/22.
//

import Foundation

enum PolicyType: String {
    case privatePolicy = "개인정보 처리방침"
    case terms = "이용약관"
}

extension PolicyType {
    var url: URL {
        switch self {
        case .privatePolicy:
            return URL(string: "https://ritzy-broom-4e0.notion.site/ff7a475faea84fe48ab5b231ad3e400d")!
        case .terms:
            return URL(string: "https://ritzy-broom-4e0.notion.site/a68c278422b840619f7e8fb5fdf68bad")!
        }
    }
}
