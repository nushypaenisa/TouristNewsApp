//
//  NewsModel.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import Foundation

// MARK: - NewsResponse

struct NewsResponse: Codable {
    
    let page: Int?
    let perPage: Int?
    let totalrecord: Int?
    let totalPages: Int?
    let data: [News]

    
}

// MARK: - News
struct News: Codable {
    var id: Int?
    var title, description: String?
    var location: String?
    var multiMedia: [MultiMedia]?
    var createdat: String?
    var user: User?
    var commentCount: Int?
}

// MARK: - MultiMedia
struct MultiMedia: Codable {
    var id: Int?
    var title: String?
    var data: Data?
    var name: String?
    var description: String?
    var url: String?
    var createat: String?
}

// MARK: - User
struct User: Codable {
    var userid: Int?
    var name: String?
    var profilepicture: String?
    var data: Data?
}




