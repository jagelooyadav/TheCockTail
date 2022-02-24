//
//  GridCardViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation

class GridCardViewModel: ItemCardDataSource {
    let drink: Drink
    
    var thumbURLString: String? {
        return drink.thumbURLString
    }
    
    init(drink: Drink) {
        self.drink = drink
    }
    
    var title: String {
        return drink.name
    }
    
    var subtitle: String {
        drink.category + ", " + drink.subCategory
    }
    
    var detailTitle: String {
        "Not given"
    }
}

