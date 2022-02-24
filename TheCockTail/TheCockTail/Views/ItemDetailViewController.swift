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
        return stack
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10.0
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        return collection
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
        view.addSubview(collectionView)
        self.collectionView.anchorToSuperView()
        collectionView.register(ItemDetailCollectionCell.self, forCellWithReuseIdentifier: "ItemDetailCollectionCell")
    }
}

extension ItemDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailCollectionCell", for: indexPath) as! ItemDetailCollectionCell
        cell.updateThumbDiamension(width: (collectionView.frame.width), height: (collectionView.frame.width))
        cell.viewModel = viewModel
        if let urlString = cell.viewModel?.thumbURLString, let url = URL(string: urlString) {
            ImageCache.publicCache.load(url: url as NSURL) { [weak cell] image in
                cell?.loadImage(image: image)
            }
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ItemDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = ItemDetailCollectionCell()
        cell.updateThumbDiamension(width: (collectionView.frame.width), height: (collectionView.frame.width))
        cell.viewModel = viewModel
        cell.layoutIfNeeded()
        return CGSize(width: (view.frame.width - 1.0), height: cell.calculateHeight(in: view.frame.width - 20.0))
    }
}
