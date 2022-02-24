//
//  GridCollectionCell.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation
import UIKit

class GridCollectionCell: ItemCardCollectionCell {
    override func updateLayout(mainStack: UIStackView, contentStack: UIStackView) {
        mainStack.axis = .vertical
        contentStack.spacing = 0.0
    }
}