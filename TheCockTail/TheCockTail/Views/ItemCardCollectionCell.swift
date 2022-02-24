//
//  ItemCardCollectionCell.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation
import UIKit

protocol ItemCardDataSource {
    var title: String { get }
    var subtitle: String { get }
    var detailTitle: String { get }
    var thumbURLString: String? { get }
}

class ItemCardCollectionCell: UICollectionViewCell {
    static let identifier = "ItemCardCollectionCell"

    private var thumbWidth: NSLayoutConstraint!
    private var thumbHeight: NSLayoutConstraint!
    
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
    
    private lazy var thumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private var thumbImageView = UIImageView()
    
    var viewModel: ItemCardDataSource? {
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
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10.0
        return stack
    }()
    
    private func setup() {
        let container = UIView()
        self.addSubview(container)
        container.anchorToSuperView(leading: 10.0, trailing: 10.0, top: 0.0, bottom: 16.0)
        container.layer.cornerRadius = 10.0
        container.backgroundColor = .grayBackground
        container.addSubview(mainStack)
        mainStack.addArrangedSubview(thumImageView)
        mainStack.anchorToSuperView(trailingRelation: .greaterOrEqual, leading: 10.0,
                                    trailing: 0.0,
                                    top: 10.0,
                                    bottom: 10.0)

        let contentSatck = UIStackView()
        contentSatck.axis = .vertical
        contentSatck.spacing = 10.0
        contentSatck.addArrangedSubview(titleLabel)
        contentSatck.addArrangedSubview(subtitleLabel)
        contentSatck.addArrangedSubview(detailTitleLabel)
        contentSatck.alignment = .leading
        mainStack.addArrangedSubview(contentSatck)
        thumbWidth = thumImageView.widthAnchor.constraint(equalToConstant: 150.0)
        thumbHeight = thumImageView.heightAnchor.constraint(equalToConstant: 80.0)
        thumbWidth.isActive = true
        thumbHeight.isActive = true
        self.updateLayout(mainStack: mainStack, contentStack: contentSatck, container: container)
    }
    
    func updateLayout(mainStack: UIStackView, contentStack: UIStackView, container: UIView) {
        /// Overridedn in sub class to change design
    }
    
    private func update() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        detailTitleLabel.text = viewModel.detailTitle
        self.layoutIfNeeded()
    }
    
    func calculateHeight(in width: CGFloat) -> CGFloat {
        layoutIfNeeded()
        setNeedsLayout()
        return mainStack.systemLayoutSizeFitting(CGSize.init(width: width, height: 0.0)).height
    }
    
    func loadImage(image: UIImage?) {
        self.thumImageView.image = image
    }
    
    func updateThumbImageDiamension(width: CGFloat, height: CGFloat) {
        thumbHeight.constant = width
        thumbWidth.constant = width
        thumImageView.contentMode = .scaleToFill
        self.layoutIfNeeded()
    }
}

