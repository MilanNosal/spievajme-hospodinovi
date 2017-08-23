//
//  UIButtonExtensions.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 22/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(color: UIColor, for state: UIControlState) {
        let image = UIImage.image(with: color)
        let insets = UIEdgeInsetsMake(0, 0, 0, 0)
        let stretchable = image.resizableImage(withCapInsets: insets, resizingMode: .tile)
        self.setBackgroundImage(stretchable, for: state)
    }
    
}
