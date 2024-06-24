//
//  ProductDetailView.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//
import Foundation
import Alamofire



class ProductDetailViewModel {
    let product: Product
    private var productDetail: ProductDetail?
    
    init(product: Product) {
        self.product = product
    }
    
    func fetchDetails(completion: @escaping (Result<ProductDetail, Error>) -> Void) {
        let request = MeliAPI.productDetail(id: product.id)
        APIClient.shared.request(request) { (result: Result<ProductDetail, AFError>) in
            switch result {
            case .success(let productDetail):
                completion(.success(productDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
