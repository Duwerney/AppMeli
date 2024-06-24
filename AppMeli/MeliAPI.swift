//
//  MeliAPI.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import Foundation
import Alamofire

enum MeliAPI {
    case search(query: String)
    case productDetail(id: String)
}

extension MeliAPI: URLRequestConvertible {
    var baseURL: URL { return URL(string: "https://api.mercadolibre.com")! }
    
    var path: String {
        switch self {
        case .search:
            return "sites/MCO/search"
        case .productDetail(let id):
            return "/items/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        
        switch self {
        case .search(let query):
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = [URLQueryItem(name: "q", value: query)]
            urlRequest.url = components.url
        case .productDetail:
            break
        }
        
        return urlRequest
    }
}
