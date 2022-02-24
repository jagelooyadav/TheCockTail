//
//  ItemCardViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation

class ItemCardViewModel: ItemCardDataSource {
    let restaurant: Restaurant
    
    var thumbURLString: String? {
        return restaurant.url
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    var title: String {
        return restaurant.name
    }
    
    var subtitle: String {
        restaurant.timeRangeString
    }
    
    var detailTitle: String {
        restaurant.location
    }
}
