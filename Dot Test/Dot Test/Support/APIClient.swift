//
//  APIClient.swift
//  Dot Test
//
//  Created by Samsul Arifin on 12/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    @discardableResult
    public static func performRequest<T:Decodable>(url:String, method:HTTPMethod, headers:HTTPHeaders, parameters:[String : Any], reqEncoding: ParameterEncoding = URLEncoding.default, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        
        return AF.request(url, method: method, parameters: parameters, encoding:reqEncoding, headers: headers)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response.result)
        }
    }
}
