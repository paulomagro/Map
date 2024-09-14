//
//  ItemAnnotation.swift
//  Map
//
//  Created by Paulo Magro on 25/08/24.
//

import Foundation
import MapKit

class ItemAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var item: Item
    
    init(item: Item) {
        self.coordinate = item.coordinate
        self.item = item
    }
}
