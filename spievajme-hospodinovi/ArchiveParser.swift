//
//  ArchiveParser.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 21/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

func parseSongsFromArchive() -> [SongStub] {
    if let dataJson = NSDataAsset(name: "spevnik.json")?.data {
        return try! JSONDecoder().decode([SongStub].self, from: dataJson)
    } else {
        return [SongStub]()
    }
}

struct SongStub: Codable {
    var number: Int
    var title: String
    var verses: [VerseStub]
    
    init(number: Int, title: String, verses: [VerseStub]) {
        self.number = number
        self.title = title
        self.verses = verses
    }
    
    func songTextDiacriticsInsensitive() -> String {
        let songText = verses.map({ $0.lines.joined(separator: " ") }).joined(separator: " ")
        let fullSong = "\(number) \(title) \(songText)"
        return fullSong.folding(options: .diacriticInsensitive, locale: Locale.current).uppercased()
    }
}

struct VerseStub: Codable {
    var number: String
    var lines: [String]
    
    init(number: String, lines: [String]) {
        self.number = number
        self.lines = lines
    }
}
