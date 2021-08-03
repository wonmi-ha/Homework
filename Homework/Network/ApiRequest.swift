//
//  ApiRequest.swift
//  Homework
//
//  Created by 하원미 on 2021/08/02.
//  Copyright © 2021 하원미. All rights reserved.
//

import Foundation

protocol ApiRequest {
    associatedtype Model: ApiResource
    var request: URLRequest? { get }
}

extension ApiRequest {
    func decode(_ data: Data) -> Model? {
        // check the received Data
        let _strData : String? = String(bytes: data, encoding: .utf8)
        print("[decode] received Data : \(_strData ?? "")")

        var aResource: Model? = nil
        let jsonDecoder = JSONDecoder()
        do {
            aResource = try jsonDecoder.decode(Model.self, from: data)
        } catch {
            print("[decode] \(error)")
        }
        return aResource
    }
    
    func load(_ completionHandler: @escaping (Model?, Error?) -> Void) {
        guard let _request = request else { return }
        self.load(_request, withCompletion: { (aResource, urlResponse, error) in
            guard let model = aResource as? Model else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }

                return
            }

            DispatchQueue.main.async {
                completionHandler(model, error)
            }
        })
    }
    
    func load(_ request: URLRequest, withCompletion completion: @escaping (ApiResource?, URLResponse?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.allowsCellularAccess = true

        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let _response = response as? HTTPURLResponse else {
                // 현재 사용 단말의 네트워크 에러
                DispatchQueue.main.async {
                    completion(nil, response, error)
                }
                return
            }
            
            // 네트워크 200 OK Check
            guard _response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(nil, response, error)
                }
                return
            }

            guard let _data = data else {
                DispatchQueue.main.async {
                    completion(nil, response, error)
                }
                return
            }

            print("Check Response : \(_response) Data : \(_data) ")
            guard let _aResource = self.decode(_data) else {
                DispatchQueue.main.async {
                    completion(nil, _response, error)
                }

                return
            }

            // 서버 에러메시지 처리
            if (_aResource.error != "0") {
                completion(_aResource, response, error)
                return
            }

            print("check the _aResource : \(_aResource)")
            completion(_aResource, response, error)
            session.invalidateAndCancel()
        }

        task.resume()
    }
}


class BookListRequest: ApiRequest {
    typealias Model = BookListResource
    var request: URLRequest?

    init(_ keyword: String, page: Int) {
        guard let _url = URL(string: String(format: ApiUrls.shared.get(.book_list), keyword, page)) else { return }
        
        let _request = URLRequest(url: _url)
        self.request = _request
    }
}


class BookDetailRequest: ApiRequest {
    typealias Model = BookDetailResource
    var request: URLRequest?

    init(_ isbn13: String) {
        guard let _url = URL(string: String(format: ApiUrls.shared.get(.book_detail), isbn13)) else { return }
        
        let _request = URLRequest(url: _url)
        self.request = _request
    }
}
