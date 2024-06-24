//
//  SplashScreen.swift
//  AppMeli
//
//  Created by user on 20/06/24.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemYellow
        // Aquí puedes agregar una imagen o animación
        navigateToSearch()
    }

    private func navigateToSearch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 segundos de splash
            let searchVC = SearchViewController()
            let navigationController = UINavigationController(rootViewController: searchVC)
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
