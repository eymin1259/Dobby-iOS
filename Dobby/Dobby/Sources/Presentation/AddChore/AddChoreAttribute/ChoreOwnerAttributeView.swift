//
//  ChoreOwnerAttributeView.swift
//  Dobby
//
//  Created by yongmin lee on 10/24/22.
//

import UIKit

final class ChoreOwnerAttributeView: AddChoreAttributeView {
    
    override init(attribute: ChoreAttribute) {
        super.init(attribute: attribute)
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didTapAddChoreAttributeView() {
        self.delegate?.extendView(attribute: self.attribute)
    }
}
