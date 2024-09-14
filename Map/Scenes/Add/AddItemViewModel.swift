//
//  AddItemViewModel.swift
//  Map
//
//  Created by Paulo Magro on 02/09/24.
//

import Foundation

class AddItemViewModel {
    let coordinator: MapCoordinator
    var isEnabled: Bindable<Bool> = .init(false)
    
    init(coordinator: MapCoordinator) {
        self.coordinator = coordinator
    }
    
    func didTapCancel() {
        coordinator.cancelAndDismiss()
    }
    
    func didTapAdd(type: ItemType, description: String) {
        coordinator.addAndDismiss(type: type, description: description )
    }
    
    func validate(text: String) {
        isEnabled.value = !text.isEmpty
    }
}
