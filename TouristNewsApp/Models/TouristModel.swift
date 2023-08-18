//
//  TouristModel.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import Foundation


// MARK: - TouristResponse
struct TouristResponse: Codable {
    let page, perPage, totalrecord, totalPages: Int?
    let data: [Tourist]

}

// MARK: - Tourist
struct Tourist: Codable {
    var id: Int?
    var data: Data?
    var touristName, touristEmail, touristLocation, touristProfilepicture, createdat: String?

}
