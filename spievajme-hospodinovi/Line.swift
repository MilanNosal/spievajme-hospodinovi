//
//  Line.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 31/07/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import Foundation

extension Line: ManagedObjectType {
    
    static var entityName: String = "Line"
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
}
