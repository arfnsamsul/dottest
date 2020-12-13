//
//  GetProfileResponse.swift
//  Dot Test
//
//  Created by Samsul Arifin on 13/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import Foundation

// MARK: - GetProfileResponse
struct GetProfileResponse: Codable {
    let statusCode: Int
    let message: String
    let data: Profile

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct Profile: Codable {
    let id: Int
    let username, fullname, email, phone: String
    let avatar: String
}
