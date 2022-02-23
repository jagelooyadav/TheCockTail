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
}

class HomeViewModel {
   
    struct Group<T>: Section {
        let groupType: GroupType
        let groupData: [T]
    }
    
    private var otherEntriesSection: [Section] = []
    
    lazy var defaultSections: [Section] = {
        let screenHeader = Group<Void>(groupType: .screenHeader, groupData: [])
        let defaultEntry = Group<Restaurant>(groupType: .defaultEntry, groupData: [Restaurant()])
        return [screenHeader, defaultEntry]
    }()
}

extension HomeViewModel: HomeViewModelProtocol {
    func fetchData(query: String) {
    }
    
    var sections: [Section] {
        return defaultSections + otherEntriesSection
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
