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
    let descriptionText: String?
    let gradient1: String?
    let gradient2: String?
    let gradient3: String?
    let gradient4: String?
    let gradient5: String?
    let measument1: String?
    let measument2: String?
    let measument3: String?
    let measument4: String?
    let measument5: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case category = "strCategory"
        case subCategory = "strAlcoholic"
        case thumbURLString = "strDrinkThumb"
        case descriptionText = "strInstructions"
        case gradient1 = "strIngredient1"
        case gradient2 = "strIngredient2"
        case gradient3 = "strIngredient3"
        case gradient4 = "strIngredient4"
        case gradient5 = "strIngredient5"
        case measument1 = "strMeasure1"
        case measument2 = "strMeasure2"
        case measument3 = "strMeasure3"
        case measument4 = "strMeasure4"
        case measument5 = "strMeasure5"
    }
}

struct Restaurant {
    let name: String = "Blue Restaurant"
    let timeRangeString = "10.00AM - 03:30PM"
    let location: String = "Steve ST Rood"
    let ratingValue: String = "4.5"
    let url = "https://www.thecocktaildb.com/images/media/drink/vwxrsw1478251483.jpg"
}
