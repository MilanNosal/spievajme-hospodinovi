//
//  FontSensitive.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 05/09/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

protocol FontSensitive {
    func setupFontScheme()
}

extension UITableViewCell: FontSensitive {
    @objc func setupFontScheme() {
    }
}
