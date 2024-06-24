//
//  ApiClient.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient()
    private init() {}
    
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(urlConvertible).validate().responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
