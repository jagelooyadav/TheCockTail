//
//  HomeViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchData(query: String)
    var sections: [Section] { get }
    var numberOfSection: Int { get }
    func numberRows(in section: Int) -> Int
    var searchText: String { get }
    func bind(with objet: Reloadable)
}

protocol Reloadable: AnyObject {
    func reloadData()
}

class HomeViewModel {
    private let service: DrinkApiService
    var sections: [Section] = []
    private weak var reloadable: Reloadable?
    
    struct Group<T>: Section {
        let groupType: GroupType
        var title: String?
        let groupData: [T]
    }
    
    init(service: DrinkApiService = DrinkApiService()) {
        self.service = service
        self.sections.append(contentsOf: defaultSections)
    }
    
    lazy var defaultSections: [Section] = {
        let screenHeader = Group<Void>(groupType: .screenHeader, groupData: [])
        let defaultEntry = Group<Restaurant>(groupType: .defaultEntry,
                                             title: "New Restaurant",
                                             groupData: [Restaurant()])
        return [screenHeader, defaultEntry]
    }()
    
    var searchText: String = "" {
        didSet {
            guard searchText.count > 1 else { return }
            self.fetchData(query: searchText)
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func fetchData(query: String) {
        service.fetchDrinks(query: query) { [weak self] result  in
            guard let self = self else { return }
            self.sections.removeAll()
            self.sections.append(contentsOf: self.defaultSections)
            switch result {
                case .success(let data):
                    
                    if !data.drinks.isEmpty {
                        let section = Group<Drink>(groupType: .otherEntries, title: "\(data.drinks.count) Items found", groupData: data.drinks)
                        self.sections.append(section)
                    }
                case .failure(let error):
                    print(error)
            }
            DispatchQueue.main.async {
                self.reloadable?.reloadData()
            }
        }
    }
    
    var numberOfSection: Int {
        return self.sections.count
    }
    
    func numberRows(in section: Int) -> Int {
        let sectionData = sections[section]
        switch sectionData.groupType {
            case .screenHeader:
                return 1
            case .defaultEntry:
                return 1
            case .otherEntries:
                if let data = sectionData as? Group<Drink> {
                    return data.groupData.count
                } else {
                    return 0
                }
        }
    }
    
    func bind(with objet: Reloadable) {
        self.reloadable = objet
    }
}

protocol Section {
    var groupType: GroupType { get }
    var title: String? { get }
}

enum GroupType {
    case screenHeader
    case defaultEntry
    case otherEntries
}
