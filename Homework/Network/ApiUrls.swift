//
//  ApiUrls.swift
//  Homework
//
//  Created by 하원미 on 2021/08/02.
//  Copyright © 2021 하원미. All rights reserved.
//

import Foundation

struct ApiUrls {
    static let shared: ApiUrls = ApiUrls()

    private init() { }

    enum URLKey: String {
        case book_list    = "/1.0/search/%@/%d"         // 책 목록
        case book_detail  = "/1.0/books/%@"          // 책 상세
    }

    func getBaseUrl() -> String {
        return "https://api.itbook.store"
    }

    func get(_ key: URLKey) -> String {
        print("check the URL = \(self.getBaseUrl())\(key.rawValue)")
        return "\(self.getBaseUrl())\(key.rawValue)"
    }
}
