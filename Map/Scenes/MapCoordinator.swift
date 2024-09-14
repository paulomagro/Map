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
    
    func presentAdd() {
        let viewModel = AddItemViewModel(coordinator: self)
        let viewController = AddItemViewController(viewModel: viewModel)
        
        viewController.modalPresentationStyle = .pageSheet
        viewController.isModalInPresentation = true
        
        if let sheet = viewController.sheetPresentationController {
            let small: UISheetPresentationController.Detent = .custom { context in
                180
            }
            sheet.largestUndimmedDetentIdentifier = small.identifier
            sheet.detents = [small]
        }
        
        navigationController.present(viewController, animated: true)
    }
    
    func addAndDismiss(type: ItemType, description: String) {
        navigationController.dismiss(animated: true)
        
        if let viewController = navigationController.topViewController as? MapViewController {
            viewController.addItem(type: type, description: description)
        }
    }
    
    func cancelAndDismiss() {
        navigationController.dismiss(animated: true)
    }
}
