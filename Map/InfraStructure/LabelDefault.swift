//
//  LabelDefault.swift
//  Map
//
//  Created by Paulo Magro on 26/08/24.
//

import Foundation
import UIKit

class LabelDefault : UILabel {
    
    init(text: String, weight: UIFont.Weight, numberOfLines: Int = 1) {
        super.init(frame: .zero)
        initDefault(text: text, weight: weight, numberOfLines: numberOfLines)
    }
   
    private func initDefault(text: String, weight: UIFont.Weight, numberOfLines: Int){
        self.text = text
        self.textColor = .black
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 12, weight: weight)
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
