//
//  GridCollectionCell.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation
import UIKit

class GridCollectionCell: ItemCardCollectionCell {
    static let identifier = "GridCollectionCell"
    override func updateLayout(mainStack: UIStackView, contentStack: UIStackView, container: UIView) {
        mainStack.axis = .vertical
        contentStack.spacing = 0.0
        container.backgroundColor = .clear
    }
    
    func updateThumbDiamension(width: CGFloat, height: CGFloat) {
        super.updateThumbImageDiamension(width: width * 0.80, height: width * 0.80)
    }
}
