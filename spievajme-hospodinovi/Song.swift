//
//  Song.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import Foundation

extension Song: ManagedObjectType {
    
    static var entityName: String = "Song"
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "number", ascending: true)]
    }
}

