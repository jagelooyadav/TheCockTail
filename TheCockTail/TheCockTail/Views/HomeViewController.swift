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
    
    // MARK: Collection Builders
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ScreenHeaderCollectionCell.self, forCellWithReuseIdentifier: "ScreenHeaderCollectionCell")
        collectionView.register(ItemCardCollectionCell.self, forCellWithReuseIdentifier: "ItemCardCollectionCell")
        collectionView.register(GridCollectionCell.self, forCellWithReuseIdentifier: "GridCollectionCell")
        collectionView.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewSectionHeader")
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

// MARK: Collection Builders
extension HomeViewController {
    private func gridCell(section: Section, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionCell", for: indexPath) as! GridCollectionCell
        let group = section as? HomeViewModel.Group<Drink>
        if let data = group?.groupData[indexPath.row] {
            cell.viewModel = GridCardViewModel(drink: data)
        }
        if let urlString = cell.viewModel?.thumbURLString, let url = URL(string: urlString) {
            ImageCache.publicCache.load(url: url as NSURL) { [weak cell] image in
                cell?.loadImage(image: image)
            }
        }
        cell.updateThumbDiamension(width: (collectionView.frame.width)/2, height: (collectionView.frame.width)/2)
        return cell
    }
    
    private func defaultEntryGridCell(section: Section, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCardCollectionCell", for: indexPath) as! ItemCardCollectionCell
        let group = section as? HomeViewModel.Group<Restaurant>
        if let data = group?.groupData.first {
            cell.viewModel = ItemCardViewModel(restaurant: data)
        }
        if let urlString = cell.viewModel?.thumbURLString, let url = URL(string: urlString) {
            ImageCache.publicCache.load(url: url as NSURL) { [weak cell] image in
                cell?.loadImage(image: image)
            }
        }
        return cell
    }
    
    private func headerCell(section: Section, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenHeaderCollectionCell", for: indexPath) as! ScreenHeaderCollectionCell
        cell.viewModel = ScreenHeaderViewModel()
        cell.searchBar.textChange
            .assign(to: \HomeViewModel.searchText, on: self.viewModel as! HomeViewModel)
            .store(in: &cancellable)
        return cell
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberRows(in: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        typealias CreateCell = (Section, UICollectionView, IndexPath) -> UICollectionViewCell
        let mapping: [GroupType: CreateCell] = [.screenHeader: self.headerCell(section:collectionView:indexPath:),
                                                .defaultEntry: self.defaultEntryGridCell(section:collectionView:indexPath:),
                                                .otherEntries: self.gridCell(section:collectionView:indexPath:)]
        return mapping[section.groupType]!(section, collectionView, indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewSectionHeader", for: indexPath) as! CollectionViewSectionHeader
            header.viewModel = SectionHeaderViewModel()
            return header
        } else {
            fatalError()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let groupType = viewModel.sections[indexPath.section].groupType
        let width = collectionView.frame.width
        if groupType == .screenHeader {
            let cell = ScreenHeaderCollectionCell()
            cell.viewModel = ScreenHeaderViewModel()
            return CGSize(width: width - 1.0, height: cell.calculateHeight())
        } else if groupType == .defaultEntry,
                  let group = viewModel.sections[indexPath.section] as? HomeViewModel.Group<Restaurant>,
                  let data = group.groupData.first {
            let cell = ItemCardCollectionCell()
            cell.viewModel = ItemCardViewModel(restaurant: data)
            return CGSize(width: width - 1.0, height: cell.calculateHeight(in: width - 1.0))
        } else {
            if groupType == .otherEntries,
               let group = viewModel.sections[indexPath.section] as? HomeViewModel.Group<Drink>,
               let data = group.groupData.first {
                let cell = GridCollectionCell()
                cell.viewModel = GridCardViewModel(drink: data)
                cell.updateThumbDiamension(width: (collectionView.frame.width)/2, height: (collectionView.frame.width)/2)
                return CGSize(width: (width - 20.0)/2, height: cell.calculateHeight(in: (width - 5.0)/2))
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if viewModel.sections[section].groupType == .defaultEntry {
            let width = collectionView.frame.width
            return CGSize.init(width: width - 1.0, height: 60.0)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupType = viewModel.sections[indexPath.section].groupType
        guard groupType == .otherEntries, let group = viewModel.sections[indexPath.section] as? HomeViewModel.Group<Drink> else  { return }
        
        let viewModel = ItemDetailViewModel(drink: group.groupData[indexPath.row])
        let controller = ItemDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension UICollectionView: Reloadable {}
