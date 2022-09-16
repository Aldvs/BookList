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
    
    let headers = ["accept":"application/json"]
    
    private init() {}

    func fetchDataAlamofire(from url: String, with completion: @escaping(Result<[ModelBook],NetworkError>) -> Void) {
        AF.request(Link.bookListApi.rawValue, method: .get, headers: .init(headers))
            .validate()
            .responseDecodable(of: [ModelBook].self) { dataResponse in
                switch dataResponse.result {
                case .success(let bookData):
                    completion(.success(bookData))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}
