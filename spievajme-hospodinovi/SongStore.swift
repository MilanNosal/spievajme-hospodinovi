//
//  SongStore.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import Foundation

fileprivate let pathForArchive: URL = {
    let appDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    let bundleDirectory = appDirectory.appendingPathComponent("\(Bundle.main.bundleIdentifier!)", isDirectory: true)
    if !FileManager.default.fileExists(atPath: bundleDirectory.path) {
        try! FileManager.default.createDirectory(at: bundleDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    return bundleDirectory.appendingPathComponent("songs.archive")
}()

class SongStore {
    
    fileprivate static var instance: SongStore?
    
    private init() {}
    
    static var shared: SongStore {
        if instance == nil {
            instance = SongStore()
        }
        return instance!
    }
    
    fileprivate var songs: [Song]?
    
    func isLoaded() -> Bool {
        return FileManager.default.fileExists(atPath: pathForArchive.path)
    }
    
    func persist(songs: [Song]) {
        _ = NSKeyedArchiver.archiveRootObject(songs, toFile: pathForArchive.path)
    }
    
    func getAllSongs() -> [Song] {
        guard isLoaded() else {
            fatalError("Database not initialized and yet a call to get all songs was made.")
        }
        if songs == nil {
            songs = NSKeyedUnarchiver.unarchiveObject(withFile: pathForArchive.path) as? [Song]
        }
        return songs!
    }
}
