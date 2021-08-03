//
//  ApiResource.swift
//  Homework
//
//  Created by 하원미 on 2021/08/02.
//  Copyright © 2021 하원미. All rights reserved.
//

import Foundation

protocol ApiResource: Codable {
    var error: String { get set }
}

struct BookListResource: ApiResource, Codable {
    var error: String
    
    var total: String
    var page: String
    var books: [BookListItemResource]
}

struct BookListItemResource: Codable {
    var title: String
    var subtitle: String
    var isbn13: String
    var price: String
    var image: String
    var url: String
}

struct BookDetailResource: ApiResource, Codable {
    var error: String
    
    var title: String
    var subtitle: String
    var authors: String
    var publisher: String
    var language: String
    var isbn10: String
    var isbn13: String
    var pages: String
    var year: String
    var rating: String
    var desc: String
    var price: String
    var image: String
    var url: String
}
