//
//  BookModel.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import UIKit

struct ModelBook: Decodable {
    let isbn: String
    let title: String
    let author: String
}

enum Link: String {
    case bookListApi = "https://demo.api-platform.com/books?page=1&itemsPerPage=30"
}

//constants for collectionview setup
struct Constants {
    static let itemsPerRow: CGFloat = 1
    static let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    static let bookMinimumLineSpacing: CGFloat = 15
    static let itemWidth = (UIScreen.main.bounds.width - (Constants.sectionInsets.left * (itemsPerRow + 1))) / Constants.itemsPerRow
    static let itemHeight = UIScreen.main.bounds.height / 5
}
