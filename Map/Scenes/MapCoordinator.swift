//
//  MapCoordinator.swift
//  Map
//
//  Created by Paulo Magro on 30/08/24.
//

import UIKit

class MapCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MapViewModel(coordinator: self)
        let viewController = MapViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
