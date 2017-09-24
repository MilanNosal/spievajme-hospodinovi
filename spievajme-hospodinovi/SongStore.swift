//
//  SongStore.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 31/07/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import Foundation

protocol SongStore {
    
    func isLoaded() -> Bool
    
    func persist(from songStubs: [SongStub], completion: @escaping ([Song]) -> Void)
    
    func getAllSongs() -> [Song]
    
    func performUpdates(block: @escaping () -> Void)
}

