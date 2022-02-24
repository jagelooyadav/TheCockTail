//
//  ItemDetailViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 25/02/22.
//

import Foundation

protocol ItemDetailViewModelDataSource: ItemCardDataSource {
    var descriptionText: String? { get }
}

class ItemDetailViewModel: GridCardViewModel, ItemDetailViewModelDataSource {
    var descriptionText: String? {
        return drink.descriptionText
    }
}
