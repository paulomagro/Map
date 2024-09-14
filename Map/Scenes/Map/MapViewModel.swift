//
//  MapViewModel.swift
//  Map
//
//  Created by Paulo Magro on 30/08/24.
//

import Foundation

class MapViewModel {
    var coordinator: MapCoordinator
    var items: [Item] = []
    
    init(coordinator: MapCoordinator) {
        self.coordinator = coordinator
    }
    
    func add(item: Item) {
        items.append(item)
    }
    
    func didTapAdd() {
        coordinator.presentAdd()
    }
    
    func markAsReturned(item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            items.append(.init(coordinate: item.coordinate, type: .returned, description: item.description))
        }
    }
}
