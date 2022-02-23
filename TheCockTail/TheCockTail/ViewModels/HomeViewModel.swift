//
//  HomeViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func startLoading()
}

class HomeViewModel: HomeViewModelProtocol {
    enum GroupType {
        case screenHeader
        case header
    }
    
    func startLoading() {
    }
}
