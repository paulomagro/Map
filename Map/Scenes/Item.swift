//
//  Item.swift
//  Map
//
//  Created by Paulo Magro on 25/08/24.
//

import Foundation
import UIKit
import MapKit

enum ItemType {
    case lost
    case found
    case returned
    
    var color: UIColor {
        switch self {
            
        case .lost:
            return UIColor.lost
        case .found:
            return .found
        case .returned:
            return .returned
        }
    }
    
    var image: UIImage? {
        switch self {
            
        case .lost:
            UIImage(systemName: "xmark.seal")
        case .found:
            UIImage(systemName: "seal")
        case .returned:
            UIImage(systemName: "checkmark.seal")
        }
    }
    
    var title: String {
        switch self {
            
        case .lost:
            "Item perdido:"
        case .found:
            "Item encontrado:"
        case .returned:
            "Item recuperado:"
        }
    }
}

struct Item {
    var coordinate: CLLocationCoordinate2D
    var type: ItemType
    var description: String
}
