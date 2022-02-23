//
//  ViewController.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var cancellable = Set<AnyCancellable>()
    
    var viewModel: HomeViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ScreenHeaderCollectionCell.self, forCellWithReuseIdentifier: "ScreenHeaderCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.bind(with: collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberRows(in: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.row].groupType {
            case .screenHeader:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenHeaderCollectionCell", for: indexPath) as! ScreenHeaderCollectionCell
                cell.viewModel = ScreenHeaderViewModel()
                cell.searchBar.textChange
                    .assign(to: \HomeViewModel.searchText, on: self.viewModel as! HomeViewModel)
                            .store(in: &cancellable)
                return cell
            case .defaultEntry:
                break
            case .otherEntries:
                break
        }
        fatalError()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cell = ScreenHeaderCollectionCell()
        cell.viewModel = ScreenHeaderViewModel()
        return CGSize(width: width - 1.0, height: cell.calculateHeight())
    }
}

extension UICollectionView: Reloadable {}
