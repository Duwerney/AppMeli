//
//  SearchViewModel.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import Foundation
import Alamofire


class SearchViewModel {
    var results: [Product] = []

    func search(query: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = MeliAPI.search(query: query)
        APIClient.shared.request(request) { (result: Result<SearchResult, AFError>) in
            switch result {
            case .success(let searchResult):
                self.results = searchResult.results
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
