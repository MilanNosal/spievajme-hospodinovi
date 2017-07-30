//
//  ArrayExtensions.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/07/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

extension Array where Element: NSLayoutConstraint {
    
    func activate() {
        NSLayoutConstraint.activate(self)
    }
    
    func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
}
