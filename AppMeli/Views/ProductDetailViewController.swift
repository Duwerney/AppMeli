//
//  ProductDetailViewController.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import UIKit
import WebKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate   {
    var viewModel: ProductDetailViewModel!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()
    
    private let colorContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dismissViewController))
        return button
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        view.backgroundColor = .white
        setupUI()
        fetchProductDetails()
        searchBar.delegate = self
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            scrollView.heightAnchor.constraint(equalToConstant: 250),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = dismissButton
        view.addSubview(titleLabel)
        view.addSubview(pageControl)
        view.addSubview(priceLabel)
        view.addSubview(conditionLabel)
        view.addSubview(colorLabel)
        view.addSubview(colorContainerView)
        view.addSubview(searchBar)
        colorContainerView.addSubview(colorLabel)
        setupScrollView()
        
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            conditionLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            conditionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            conditionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            colorLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 20),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func fetchProductDetails() {
        viewModel.fetchDetails { [weak self] result in
            switch result {
            case .success(let productDetail):
                DispatchQueue.main.async {
                    self?.updateUI(with: productDetail)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUI(with productDetail: ProductDetail) {
        titleLabel.text = productDetail.title
        
        
        if let pictures = productDetail.pictures {
            showImages(pictures, videoId: productDetail.videoId)
            pageControl.numberOfPages = pictures.count + (productDetail.videoId == nil ? 0 : 1)
        }
        priceLabel.text = "Price: \(productDetail.price)"
        conditionLabel.text = "Condition: \(productDetail.condition ?? "")"
        colorLabel.font = .boldSystemFont(ofSize: 17)
        colorLabel.text = "\(productDetail.warranty ?? "")"
        
    }
    
    private func showImages(_ pictures: [Picture], videoId: String?) {
        if let videoId = videoId {
            let webView = WKWebView()
            webView.translatesAutoresizingMaskIntoConstraints = false
            if let videoURL = URL(string: "https://www.youtube.com/embed/\(videoId)") {
                webView.load(URLRequest(url: videoURL))
            }
            stackView.addArrangedSubview(webView)
            NSLayoutConstraint.activate([
                webView.widthAnchor.constraint(equalToConstant: 300),
                webView.heightAnchor.constraint(equalToConstant: 250)
            ])
        }
        
        for picture in pictures {
            if let imageUrl = URL(string: picture.url) {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                // Load image asynchronously
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: imageData)
                        }
                    }
                }
                
                // Extract size
                let (width, height) = extractSize(from: picture.size)
                
                // Add imageView to horizontal stackView
                stackView.addArrangedSubview(imageView)
                
                // Add constraints for size based on extracted size
                if let width = width, let height = height {
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(equalToConstant: CGFloat(width)),
                        imageView.heightAnchor.constraint(equalToConstant: CGFloat(height))
                    ])
                }
            }
        }
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(pictures.count)).isActive = true
    }
    
    private func extractSize(from sizeString: String?) -> (Int?, Int?) {
        guard let sizeString = sizeString else { return (nil, nil) }
        let components = sizeString.split(separator: "x")
        if components.count == 2,
           let width = Int(components[0]),
           let height = Int(components[1]) {
            return (width, height)
        }
        return (nil, nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}


extension ProductDetailViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
