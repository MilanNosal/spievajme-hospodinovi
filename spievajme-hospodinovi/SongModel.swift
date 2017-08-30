//
//  SongModel.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import Foundation

struct SongModel {
    
    let songNumber: Int
    let songTitle: String
    var verses: [(title: String, text: String)] = []
    
    init(song: Song) {
        songNumber = Int(song.number)
        songTitle = song.title!
        
        let lineSeparator = UserDefaults.standard.verseAsContinuousText ? " / " : "\n"
        
        if UserDefaults.standard.refrainsWithVerses {
            verses = parseVersesWithRefrains(song: song, lineSeparator: lineSeparator)
        } else {
            verses = parseVersesWithSeparateRefrains(song: song, lineSeparator: lineSeparator)
        }
    }
    
    
    fileprivate func parseVersesWithSeparateRefrains(song: Song, lineSeparator: String) -> [(title: String, text: String)] {
        var verses: [(title: String, text: String)] = []
        for verse in song.verses! {
            let verse = verse as! Verse
            let verseText = verse.lines!.map({ (line) -> String in
                return (line as! Line).text!
            }).joined(separator: lineSeparator)
            
            verses.append((title: verse.number ?? "", text: verseText))
        }
        return verses
    }
    
    fileprivate func parseVersesWithRefrains(song: Song, lineSeparator: String) -> [(title: String, text: String)] {
        var verses: [(title: String, text: String)] = []
        for verse in song.verses! {
            let currentIndex = verses.count - 1
            let verse = verse as! Verse
            let verseText = verse.lines!.map({ (line) -> String in
                return (line as! Line).text!
            }).joined(separator: lineSeparator)
            
            if verse.number == "Ref" {
                if currentIndex < 0 {
                    verses.append((title: "Ref", text: "[Ref] \(verseText)"))
                } else {
                    verses[currentIndex].text.append("\(lineSeparator)[Ref] \(verseText)")
                }
            } else {
                verses.append((title: verse.number ?? "", text: verseText))
            }
        }
        return verses
    }
}
