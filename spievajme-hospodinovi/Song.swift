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
    
    func isAccepted(bySearchString searchString: String) -> Bool {
        guard !searchString.isEmpty else {
            return true
        }
        if Int(searchString) != nil {
            return String(self.number).contains(searchString)
        } else {
            return self.searchableCacheString!.contains(searchString)
        }
    }
}

