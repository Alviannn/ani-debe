//
//  BaseService.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import Foundation

typealias CompletePaginatedHandler<T: Codable> = (ArrayResponse<T>?, Error?) -> Void

typealias CompleteHandler<T: Codable> = (Response<T>?, Error?) -> Void

class BaseJikanService {
    
    let baseUrl: String
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        self.urlSession = URLSession.shared
        self.jsonDecoder = JSONDecoder()
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchPaginatedFromUrl<T: Codable>(stringUrl: String, onCompleteHandler: @escaping CompletePaginatedHandler<T>) {
        let url = URL(string: stringUrl)!
        
        urlSession.dataTask(with: url, completionHandler: { data, _, err in
            if err != nil {
                onCompleteHandler(nil, err)
                return
            }
            
            do {
                let response = try self.jsonDecoder.decode(ArrayResponse<T>.self, from: data!)
                onCompleteHandler(response, nil)
            } catch let newError {
                onCompleteHandler(nil, newError)
            }
        }).resume()
    }
    
    func fetchFromUrl<T: Codable>(stringUrl: String, onCompleteHandler: @escaping CompleteHandler<T>) {
        let url = URL(string: stringUrl)!
        
        urlSession.dataTask(with: url, completionHandler: { data, _, err in
            if err != nil {
                onCompleteHandler(nil, err)
                return
            }
            
            do {
                let response = try self.jsonDecoder.decode(Response<T>.self, from: data!)
                onCompleteHandler(response, nil)
            } catch let newError {
                onCompleteHandler(nil, newError)
            }
        }).resume()
    }
    
}
