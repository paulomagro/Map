//
//  ItemAnnotationView.swift
//  Map
//
//  Created by Paulo Magro on 25/08/24.
//

import Foundation
import MapKit

class ItemAnnotationView: MKMarkerAnnotationView {
    func configure(annotation: ItemAnnotation) {
        markerTintColor = annotation.item.type.color
    }
}
