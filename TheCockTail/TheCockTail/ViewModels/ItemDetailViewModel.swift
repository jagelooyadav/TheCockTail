//
//  ItemDetailViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 25/02/22.
//

import Foundation

protocol ItemDetailViewModelDataSource: ItemCardDataSource {
    var descriptionText: String? { get }
    var gradientsPlaceHolder: String { get }
    var measurmentPlaceholder: String { get }
    var gradients: [String] { get }
    var measurments: [String] { get }
    var instructionPlaceholder: String { get }
}

class ItemDetailViewModel: GridCardViewModel, ItemDetailViewModelDataSource {
    var gradients: [String] = []
    var measurments: [String] = []
    
    override init(drink: Drink) {
        super.init(drink: drink)
        self.gradients = [drink.gradient1,
                          drink.gradient2,
                          drink.gradient3,
                          drink.gradient4,
                          drink.gradient5].compactMap { $0 }
        self.measurments = [drink.measument1,
                          drink.measument1,
                          drink.measument1,
                          drink.measument1,
                          drink.measument1].compactMap { $0 }
    }
    
    var descriptionText: String? {
        return drink.descriptionText
    }
    
    var gradientsPlaceHolder: String {
        return "Gradients"
    }
    var measurmentPlaceholder: String {
        return "Measurments"
    }
    
    var instructionPlaceholder: String { "Instructions" }
}
