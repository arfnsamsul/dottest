//
//  GetPlaceResponse.swift
//  Dot Test
//
//  Created by Samsul Arifin on 12/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import Foundation

// MARK: - GetPlaceResponse
struct GetPlaceResponse: Codable {
    let statusCode: Int
    let message: String
    let data: PlaceResponse

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - PlaceResponse
struct PlaceResponse: Codable {
    let header: Header
    let content: [Place]
}

// MARK: - Place
struct Place: Codable {
    let id: Int
    let title, content, type: String
    let image: String?
    let media: [String]
}

// MARK: - Header
struct Header: Codable {
    let title, subtitle: String
}
