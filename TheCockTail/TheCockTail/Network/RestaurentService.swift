//
//  RestaurentService.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 12/04/22.
//

import Foundation

protocol RestaurentDataProvider {
    typealias ServiceCompletion = (Restaurant) -> Void
    func getRestaurentData(completion: ServiceCompletion?)
}

class RestaurentService: RestaurentDataProvider {
    func getRestaurentData(completion: ServiceCompletion?) {
        DispatchQueue.main.async {
            completion?(Restaurant())
        }
    }
}
