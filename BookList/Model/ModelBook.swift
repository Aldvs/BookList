//
//  BookModel.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import Foundation

struct ModelBook: Decodable {
    let title: String
    let isbn: String
    let author: String
}

enum Link: String {
    case bookListApi = "https://demo.api-platform.com/books?page=1&itemsPerPage=30"
}

//curl -X 'GET' \
//  'https://demo.api-platform.com/books?page=1&itemsPerPage=30'
//  -H 'accept: application/vnd.api+json'
