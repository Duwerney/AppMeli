//
//  SearchViewController.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    private let viewModel = SearchViewModel()
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray3
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        searchBar.layer.borderColor = UIColor.yellow.cgColor
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    private func fetchProducts(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        viewModel.search(query: query) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching products: \(error.localizedDescription)")
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        viewModel.search(query: query) { [weak self] result in
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                // Manejo de errores
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = viewModel.results[indexPath.row]
        cell.configure(with: product)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.results[indexPath.row]
        let detailVC = ProductDetailViewController()
        detailVC.viewModel = ProductDetailViewModel(product: product)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
