//
//  NetworkManager.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation

protocol APIClientProtocol {
    func call<Response: Decodable>(request: String, completion: ((Result<Response, Error>) -> Void)?)
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let endPoint = "https://thecocktaildb.com/api/json/v1/1/search.php?s="
    var isStub = false
}

extension NetworkManager: APIClientProtocol {
    func call<Response: Decodable>(request: String, completion: ((Result<Response, Error>) -> Void)?) {
        let urlToHit = endPoint + request
        DispatchQueue.global().async {
            let url: URL?
            if self.isStub {
                guard let filepath = Bundle.main.path(forResource: "apistub", ofType: "json") else {
                    completion?(.failure(CustomError.invalidURL))
                    return
                }
                url = URL(fileURLWithPath: filepath)
            } else {
                url = URL(string: urlToHit)
            }
            guard let url = url else {
                completion?(.failure(CustomError.invalidRequest))
                return
            }
            guard let data = try? Data(contentsOf: url, options: .alwaysMapped) else {
                completion?(.failure(CustomError.invalidResponse))
                return
            }
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                completion?(.failure(CustomError.unableToParse))
                return
            }
            completion?(.success(response))
        }
    }
}

enum CustomError: Error {
    case invalidRequest
    case invalidResponse
    case unableToParse
    case invalidURL
    
    var errorDescription: String {
            switch self {
                case .invalidRequest:
                    return "Invalid Request"
                case .invalidResponse:
                    return "Invalid Response"
                case .unableToParse:
                    return "Something went wrong"
                case .invalidURL:
                    return "Wrong end point"
            }
        }
}
