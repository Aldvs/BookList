//
//  NetworkingManager.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import Foundation

import Alamofire

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    func fetchDataAlamofire(from url: String, with completion: @escaping(Result<ModelBook,NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: ModelBook.self) { dataResponse in
                switch dataResponse.result {
                case .success(let books):
                    completion(.success(books))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}
