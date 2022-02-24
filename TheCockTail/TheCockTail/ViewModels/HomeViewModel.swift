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
    
    private weak var reloadable: Reloadable?
    
    struct Group<T>: Section {
        let groupType: GroupType
        let groupData: [T]
    }
    
    init(service: DrinkApiService = DrinkApiService()) {
        self.service = service
    }
    
    private var otherEntriesSection: [Section] = []
    
    lazy var defaultSections: [Section] = {
        let screenHeader = Group<Void>(groupType: .screenHeader, groupData: [])
        let defaultEntry = Group<Restaurant>(groupType: .defaultEntry, groupData: [Restaurant()])
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
            self?.otherEntriesSection.removeAll()
            switch result {
                case .success(let data):
                    
                    if !data.drinks.isEmpty {
                        let section = Group<Drink>(groupType: .otherEntries, groupData: data.drinks)
                        self?.otherEntriesSection = [section]
                    }
                case .failure(let error):
                    print(error)
            }
            DispatchQueue.main.async {
                self?.reloadable?.reloadData()
            }
        }
    }
    
    var sections: [Section] {
        return defaultSections + otherEntriesSection
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
}

enum GroupType {
    case screenHeader
    case defaultEntry
    case otherEntries
}
