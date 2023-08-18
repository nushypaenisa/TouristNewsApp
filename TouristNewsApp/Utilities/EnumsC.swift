//
//  EnumsC.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import Foundation

enum ResponseError: Error{
    
    case invalidUrl
    case invalidResponse
    case invalidData
    
}
enum APIError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}
