//
//  SongController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class SongController: UITableViewController {
    
    var song: Song? {
        didSet {
            if let song = song {
                if song.number != oldValue?.number {
                    self.navigationItem.title = song.title
                    navigationItem.rightBarButtonItem = UIBarButtonItem()
                    navigationItem.rightBarButtonItem?.title = String(song.number)
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.black
                    
                    let lineSeparator = UserDefaults.standard.verseAsContinuousText ? " / " : "\n"
                    
                    if UserDefaults.standard.refrainsWithVerses {
                        parseVersesWithRefrains(song: song, lineSeparator: lineSeparator)
                    } else {
                        parseVersesWithSeparateRefrains(song: song, lineSeparator: lineSeparator)
                    }
                    
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            }
        }
    }
    
    fileprivate func parseVersesWithSeparateRefrains(song: Song, lineSeparator: String) {
        verses.removeAll()
        for verse in song.verses! {
            let verse = verse as! Verse
            let verseText = verse.lines!.map({ (line) -> String in
                return (line as! Line).text!
            }).joined(separator: lineSeparator)
            
            verses.append((title: verse.number ?? "", text: verseText))
        }
    }
    
    fileprivate func parseVersesWithRefrains(song: Song, lineSeparator: String) {
        verses.removeAll()
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
    }
    
    fileprivate var verses: [(title: String, text: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(VerseCell.self, forCellReuseIdentifier: VerseCell.identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return verses.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return verses[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VerseCell.identifier) as! VerseCell
        cell.verse = verses[indexPath.section].text
        return cell
    }
}
