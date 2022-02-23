//
//  DrinkApiService.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//
import Foundation

protocol ServiceProvider {
    typealias ServiceCompletion = (Result<DrinkApiResponse, Error>) -> Void
    func fetchDrinks(query: String, completion: ServiceCompletion?)
}

class DrinkApiService {
    
    private let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol = NetworkManager.shared) {
        self.apiClient = apiClient
    }
}

extension DrinkApiService: ServiceProvider {
    func fetchDrinks(query: String, completion: ServiceCompletion?) {
        typealias DResult = Result<DrinkApiResponse, Error>
        apiClient.call(request: query) { (result: DResult) in
            /// Any custom errror or api specific handling can be done here
            completion?(result)
        }
    }
}
