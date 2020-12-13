//
//  GetGalleryResponse.swift
//  Dot Test
//
//  Created by Samsul Arifin on 13/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import Foundation

// MARK: - GetGalleryResponse
struct GetGalleryResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [GalleryItem]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - GalleryItem
struct GalleryItem: Codable {
    let caption: String
    let thumbnail, image: String
}
