//
//  UILabel.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, alignment: NSTextAlignment) {
        self.init()
        
        self.text = text
        self.font = font
        self.textAlignment = alignment
        self.textColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
    }
}
