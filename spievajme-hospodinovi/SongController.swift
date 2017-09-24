//
//  SongController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class SongController: UITableViewController {
    
    var songModel: SongModel? {
        didSet {
            if let songModel = songModel {
                if songModel.songNumber != oldValue?.songNumber {

                    self.navigationItem.title = songModel.songTitle
                    navigationItem.rightBarButtonItem = UIBarButtonItem()
                    navigationItem.rightBarButtonItem?.title = String(songModel.songNumber)
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.black
                    
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(VerseCell.self, forCellReuseIdentifier: VerseCell.identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 35
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
        return songModel?.verses.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = songModel?.verses[section].title ?? ""
        let view = VerseHeaderView()
        view.header = title
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VerseCell.identifier) as! VerseCell
        cell.verse = songModel?.verses[indexPath.section].text ?? ""
        cell.setupFontScheme()
        return cell
    }
}
