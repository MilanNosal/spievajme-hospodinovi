//
//  Song.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import Foundation

class Song: NSObject, NSCoding {
    var number: Int = 0
    var title: String = ""
    var verses: [Verse] = []
    
    override init() {
        super.init()
    }
    
    convenience init(number: Int, title: String, verses: [Verse]) {
        self.init()
        self.number = number
        self.title = title
        self.verses = verses
    }
    
    // MARK: NSCoding implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(number, forKey: "number")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(verses, forKey: "verses")
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        
        self.number = aDecoder.decodeInteger(forKey: "number")
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.verses = aDecoder.decodeObject(forKey: "verses") as! [Verse]
    }
}

