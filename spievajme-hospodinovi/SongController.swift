//
//  SongController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class SongController: UITableViewController {
    
    var song: Song! {
        didSet {
            if song.number != oldValue?.number {
                self.navigationItem.title = song.title
                navigationItem.rightBarButtonItem = UIBarButtonItem()
                navigationItem.rightBarButtonItem?.title = String(song.number)
                navigationItem.rightBarButtonItem?.tintColor = UIColor.black
                
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(VerseCell.self, forCellReuseIdentifier: VerseCell.identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return song.verses!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (song.verses![section] as! Verse).number
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VerseCell.identifier) as! VerseCell
        cell.verse = song.verses![indexPath.section] as! Verse
        return cell
        
    }
}
