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
        let item = annotation.item
        markerTintColor = item.type.color
        glyphImage = item.type.image
        
        canShowCallout = true
        detailCalloutAccessoryView = AccesoryView(item: item)
        if (item.type != .returned) {
            let button = UIButton(frame: .init(x: 0, y: 0, width: 100, height: 40))
            let title = item.type == .lost ? "Marcar como\nencontrado" : "Marcar como\ndevolvido"
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = .center
            button.backgroundColor = item.type.color
            button.layer.cornerRadius = 8
            
            rightCalloutAccessoryView = button
        } else {
            rightCalloutAccessoryView = nil
        }
    }
    
    class AccesoryView: UIView {
        var item: Item
        
        let contentStack: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var titleLabel = LabelDefault(text: item.type.title, weight: .bold)
        lazy var itemLabel = LabelDefault(text: item.description, weight: .regular, numberOfLines: 0)
        
        init(item: Item) {
            self.item = item
            super.init(frame: .zero)
            setupView()
        }
        
        func setupView() {
            addSubview(contentStack)
            contentStack.addArrangedSubview(titleLabel)
            contentStack.addArrangedSubview(itemLabel)
            
            NSLayoutConstraint.activate([
                contentStack.topAnchor.constraint(equalTo: topAnchor),
                contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
