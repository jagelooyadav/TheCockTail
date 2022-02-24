//
//  ItemDetailViewController.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 25/02/22.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController {
    private let scrollingContentView = UIView()
    private let viewModel: ItemDetailViewModelDataSource
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10.0
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    init(viewModel: ItemDetailViewModelDataSource) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        setupScroll()
        setupThumb()
        setupOtherElements()
    }
    
    func setupThumb() {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        if let urlString = viewModel.thumbURLString, let url = URL(string: urlString) {
            ImageCache.publicCache.load(url: url as NSURL) { image in
                imageView.image = image
            }
        }
        contentStack.addArrangedSubview(imageView)
        
        scrollingContentView.addSubview(contentStack)
        contentStack.anchorToSuperView(bottomRelation: .greaterOrEqual, leading: 16.0, trailing: 16.0)
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32.0).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -32.0).isActive = true
    }
    
    func setupOtherElements() {
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(subtitleLabel)
        contentStack.addArrangedSubview(detailTitleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        detailTitleLabel.text = viewModel.detailTitle
        descriptionLabel.text = viewModel.descriptionText
        
    }
    
    private func setupScroll() {
        let wrapperView = UIView()
        let scrollView = UIScrollView()
        wrapperView.backgroundColor = .clear
        self.view.addSubview(wrapperView)
        wrapperView.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        scrollView.backgroundColor = .clear
        wrapperView.addSubview(scrollView)
        scrollView.anchorToSuperView()
        scrollingContentView.backgroundColor = .clear
        scrollView.addSubview(scrollingContentView)
        scrollingContentView.anchorToSuperView()
        scrollingContentView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor).isActive = true
        scrollingContentView.heightAnchor.constraint(greaterThanOrEqualTo: wrapperView.heightAnchor).isActive = true
        view.backgroundColor = .white
    }
}
