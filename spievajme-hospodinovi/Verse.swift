//
//  Verse.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/07/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import Foundation

class Verse: NSObject, NSCoding {
    var number: String = ""
    var lines: [String] = []
    
    override init() {
        super.init()
    }
    
    convenience init(number: String, lines: [String]) {
        self.init()
        self.number = number
        self.lines = lines
    }
    
    // MARK: NSCoding implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(number, forKey: "number")
        aCoder.encode(lines, forKey: "lines")
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        
        self.number = aDecoder.decodeObject(forKey: "number") as! String
        self.lines = aDecoder.decodeObject(forKey: "lines") as! [String]
    }
}
