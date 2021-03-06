//
//  MainLoader.swift
//  Dot Test
//
//  Created by Samsul Arifin on 12/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import Foundation
import Alamofire

class MainLoader {
    public static func getPlace(completion:@escaping (Result<GetPlaceResponse, AFError>)->Void){
        APIClient.performRequest(url: DotConstant.placeUrl, method: .get, headers: [:], parameters: [:], completion:completion)
    }
    public static func getGallery(completion:@escaping (Result<GetGalleryResponse, AFError>)->Void){
        APIClient.performRequest(url: DotConstant.galleryUrl, method: .get, headers: [:], parameters: [:], completion:completion)
    }
    public static func getProfile(completion:@escaping (Result<GetProfileResponse, AFError>)->Void){
        APIClient.performRequest(url: DotConstant.profileUrl, method: .get, headers: [:], parameters: [:], completion:completion)
    }
}
