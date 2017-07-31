//
//  SongsXMLParser.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/07/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

func parseSongsFromXMLArchive() -> [SongStub] {
    if let data = NSDataAsset(name: "spevnik")?.data {
        let parser = XMLParser(data: data)
        let sp = SongsXMLParser()
        parser.delegate = sp
        parser.parse()
        return sp.songs
    } else {
        return [SongStub]()
    }
}

struct SongStub {
    var number: Int
    var title: String
    var verses: [VerseStub]
    
    init(number: Int, title: String, verses: [VerseStub]) {
        self.number = number
        self.title = title
        self.verses = verses
    }
}

struct VerseStub {
    var number: String
    var lines: [String]
    
    init(number: String, lines: [String]) {
        self.number = number
        self.lines = lines
    }
}

enum SupportedTags: String {
    case book = "BIBLEBOOK"
    case chapter = "CHAPTER"
    case title = "TITLE"
    case verse = "VERS"
}

class SongsXMLParser: NSObject, XMLParserDelegate {
    
    var songs = [SongStub]()
    var currentSongNumber: Int?
    var currentSongTitle: String?
    var currentSongVerses: [VerseStub]?
    
    var currentTag: SupportedTags? = nil
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
            
        case SupportedTags.chapter.rawValue:
            if let numberString = attributeDict["cnumber"] {
                currentSongNumber = Int(numberString)
            }
            currentSongTitle = nil
            currentSongVerses = nil
            
            currentTag = .chapter
            
        case SupportedTags.title.rawValue:
            currentSongTitle = ""
            currentTag = .title
            
        case SupportedTags.verse.rawValue:
            if currentSongVerses == nil {
                currentSongVerses = []
            }
            let verse = VerseStub(number: attributeDict["vnumber"] ?? "", lines: [])
            currentSongVerses!.append(verse)
            
            currentTag = .verse
            
        default:
            currentTag = nil
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if let current = currentTag {
            
            switch current {
                
            case .title:
                if currentSongTitle != nil {
                    currentSongTitle!.append(string)
                } else {
                    currentSongTitle = string
                }
                
            default:
                break
                
            }
            
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        
        if let current = currentTag {
            
            switch current {
                
            case .verse:
                if  let string = String(data: CDATABlock, encoding: String.Encoding.utf8),
                    let currentSongVerses = currentSongVerses, !currentSongVerses.isEmpty {
                    
                    self.currentSongVerses![self.currentSongVerses!.count - 1].lines.append(string)
                    
                }
                
            default:
                break
                
            }
            
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        currentTag = nil
        
        switch elementName {
            
        case SupportedTags.chapter.rawValue:
            
            if
                let songNumber = currentSongNumber,
                let songTitle = currentSongTitle,
                let verses = currentSongVerses
            {
                let song = SongStub(number: songNumber, title: songTitle, verses: verses)
                songs.append(song)
                
                currentSongNumber = nil
                currentSongTitle = nil
                currentSongVerses = nil
            }
            
        default:
            break
            
        }
        
    }
}
