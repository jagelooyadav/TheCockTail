//
//  CollectionViewSectionHeader.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation
import UIKit

protocol CollectionViewSectionHeaderDataSource {
    var buttonTitle: String { get }
    var title: String { get }
}

class CollectionViewSectionHeader: UICollectionReusableView {
    
    var viewModel: CollectionViewSectionHeaderDataSource? {
        didSet {
            self.update()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var button = UIButton()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20.0
        stack.axis = .horizontal
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.addSubview(stackView)
        stackView.anchorToSuperView(leading: 16.0, trailing: 16.0)
        stackView.addArrangedSubview(titleLabel)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: self.traitCollection)
        let spacer = UIView()
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(button)
        titleLabel.text = ""
    }
    
    private func update() {
        titleLabel.text = viewModel?.title
        button.setTitle(viewModel?.buttonTitle, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
