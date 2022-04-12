//
//  HomeViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchData(query: String)
    func fetchRestaurent()
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
    private let service: ServiceProvider
    private let restaurentService: RestaurentDataProvider
    var sections: [Section] = []
    private weak var reloadable: Reloadable?
    
    struct Group<T>: Section {
        let groupType: GroupType
        var title: String?
        let groupData: [T]
    }
    
    init(service: ServiceProvider = DrinkApiService(),
         restaurentService: RestaurentDataProvider = RestaurentService()) {
        self.service = service
        self.restaurentService = restaurentService
    }
    
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
            DispatchQueue.main.async {
                self.sections.removeAll(where: { $0.groupType == .otherEntries })
                switch result {
                    case .success(let data):
                        
                        if !data.drinks.isEmpty {
                            let section = Group<Drink>(groupType: .otherEntries, title: "\(data.drinks.count) Items found", groupData: data.drinks)
                            self.sections.append(section)
                        }
                    case .failure(let error):
                        print(error)
                }
                self.reloadable?.reloadData()
            }
        }
    }
    
    func fetchRestaurent() {
        self.sections.removeAll()
        restaurentService.getRestaurentData { [weak self] data in
            guard let self = self else { return }
            let screenHeader = Group<Void>(groupType: .screenHeader, groupData: [])
            let defaultEntry = Group<Restaurant>(groupType: .defaultEntry,
                                                 title: "New Restaurant",
                                                 groupData: [data])
            self.sections.append(screenHeader)
            self.sections.append(defaultEntry)
            self.reloadable?.reloadData()
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
