//
//  ButtonDefault.swift
//  Map
//
//  Created by Paulo Magro on 30/08/24.
//

import UIKit

class ButtonDefault: UIButton {
    
    init(text: String, imageName: String = "", backgroundColor: UIColor = .white, fontWeight: UIFont.Weight = .regular) {
        super.init(frame: .zero)
        initDefault(text: text, fontWeight: fontWeight, backgroundColor: backgroundColor, imageName: imageName)
      }
    
    private func initDefault(text: String, fontWeight: UIFont.Weight, backgroundColor: UIColor, imageName: String) {
        self.setTitle(text, for: .normal)
        let titleColor = (backgroundColor == .black) ? UIColor.white : UIColor.black
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(.white.withAlphaComponent(0.5), for: .disabled)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: fontWeight)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 8
        if !imageName.isEmpty {
            self.setImage(UIImage(systemName: imageName), for: .normal)
            self.tintColor = titleColor
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
