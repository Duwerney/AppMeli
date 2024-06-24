//
//  ProductDetailView.swift
//  AppMeli
//
//  Created by user on 21/06/24.
//

import UIKit

class ProductDetailView: UIView {
    private let idLabel = UILabel()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(idLabel)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(imageView)

        // Configura los elementos de UI 
        idLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        priceLabel.numberOfLines = 0
        imageView.contentMode = .scaleAspectFill

        // Configura el layout de los elementos de UI
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            imageView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }

    func configure(with productDetail: ProductDetail) {
        idLabel.text = "ID: \(productDetail.id)"
        titleLabel.text = "Title: \(productDetail.title)"
        priceLabel.text = "Price: \(productDetail.price)"

        if let firstPicture = productDetail.pictures?.first, let imageUrl = URL(string: firstPicture.url) {
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
