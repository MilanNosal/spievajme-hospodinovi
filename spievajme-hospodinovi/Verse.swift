//
//  Verse.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/07/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import Foundation

extension Verse: ManagedObjectType {
    
    static var entityName: String = "Verse"
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "number", ascending: true)]
    }
}

