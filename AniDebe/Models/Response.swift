//
//  Response.swift
//  AniDebe
//
//  Created by prk on 1/10/23.
//

import Foundation

struct ArrayResponse<T: Codable>: Codable {
    
    let data: [T]
    let pagination: Pagination?
    
}

struct Response<T: Codable>: Codable {
    
    let data: T
    
}

struct Pagination: Codable {

    let lastVisiblePage: Int
    let hasNextPage: Bool
    let currentPage: Int
    let items: PaginationItems
    
}

struct PaginationItems: Codable {
    
    let count: Int
    let total: Int
    let perPage: Int
    
}
