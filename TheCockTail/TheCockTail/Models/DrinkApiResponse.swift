//
//  DrinkApiResponse.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import Foundation

struct DrinkApiResponse: Decodable {
    let drinks: [Drink]
}

struct Drink: Decodable {
    let name: String
    let category: String
    let subCategory:String
    let thumbURLString: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case category = "strCategory"
        case subCategory = "strAlcoholic"
        case thumbURLString = "strDrinkThumb"
    }
}

struct Restaurant {
    let name: String = "Blue Restaurant"
    let timeRangeString = "10.00AM - 03:30PM"
    let location: String = "Steve ST Rood"
    let ratingValue: String = "4.5"
}
