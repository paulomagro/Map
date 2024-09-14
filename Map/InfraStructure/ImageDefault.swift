//
//  ImageDefault.swift
//  Map
//
//  Created by Paulo Magro on 10/09/24.
//

import UIKit

class ImageDefault : UIImageView {
    
    init(image: String) {
        super.init(frame: .zero)
        initDefault(image: image)
    }
   
    private func initDefault(image: String) {
        self.image = UIImage(systemName: image)
        self.tintColor = .black
        self.backgroundColor = .clear
        self.contentMode = .scaleAspectFit
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
