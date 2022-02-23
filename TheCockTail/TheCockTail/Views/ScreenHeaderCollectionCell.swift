//
//  ScreenHeaderCollectionCell.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import Foundation
import UIKit

protocol ScreenHeaderProtocol {
    var headerTitle: String { get }
    var searchText: String? { get set }
}

class ScreenHeaderCollectionCell: UICollectionViewCell {
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var searchBar: RoundedSearchTextField = RoundedSearchTextField()
    
    var viewModel: ScreenHeaderProtocol? {
        didSet {
            self.update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let container = UIView()
        self.addSubview(container)
        container.anchorToSuperView()
        
       container.addSubview(headerLabel)
        headerLabel.anchorToSuperView(trailingRelation: .greaterOrEqual, bottomRelation: .ignore, leading: 16.0, trailing: 16.0, top: 40.0)
        container.addSubview(searchBar)
        searchBar.anchorToSuperView(topAnchor: headerLabel.bottomAnchor, trailingRelation: .greaterOrEqual, leading: 16.0, trailing: 16.0, top: 20.0, bottom: 20.0)
        searchBar.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
    }
    
    private func update() {
        guard let viewModel = viewModel else { return }
        headerLabel.text = viewModel.headerTitle
        self.layoutIfNeeded()
    }
    
    func calculateHeight() -> CGFloat {
        self.layoutIfNeeded()
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
