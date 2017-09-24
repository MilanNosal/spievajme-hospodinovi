//
//  SongStoreCoreData.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import CoreData

class SongStoreCoreData: SongStore {
    
    fileprivate static var instance: SongStore?
    
    private init() {}
    
    static var shared: SongStore {
        if instance == nil {
            instance = SongStoreCoreData()
        }
        return instance!
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "spevnik")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    fileprivate var songs: [Song]?
    
    func isLoaded() -> Bool {
        
        let request: NSFetchRequest<Song> = NSFetchRequest<Song>(entityName: Song.entityName)
        request.includesSubentities = false
        let count = try? persistentContainer.viewContext.count(for: request)
        
        if let count = count, count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func persist(from songStubs: [SongStub], completion: @escaping ([Song]) -> Void) {
        let context = persistentContainer.viewContext
        var songs: [Song] = []
        context.performChanges(completion: { (success) in
            completion(songs)
        }, block: {
            for songStub in songStubs {
                songs.append(self.createSong(for: songStub, in: context))
            }
        })
    }
    
    fileprivate func createSong(for songStub: SongStub, in context: NSManagedObjectContext) -> Song {
        var verses: [Verse] = []
        for verseStub in songStub.verses {
            var lines: [Line] = []
            for lineText in verseStub.lines {
                let line: Line = context.createObject()
                line.text = lineText
                lines.append(line)
            }
            let verse: Verse = context.createObject()
            verse.number = verseStub.number
            verse.addToLines(NSOrderedSet(array: lines))
            verses.append(verse)
        }
        let song: Song = context.createObject()
        song.number = Int32(songStub.number)
        song.title = songStub.title
        song.isFavourite = false
        song.addToVerses(NSOrderedSet(array: verses))
        return song
    }
    
    func getAllSongs() -> [Song] {
        let request: NSFetchRequest<Song> = Song.sortedFetchRequest()
        let songs: [Song] = try! persistentContainer.viewContext.fetch(request)
        return songs
    }
    
    func performUpdates(block: @escaping () -> Void) {
        persistentContainer.viewContext.performChanges {
            block()
        }
    }
}
