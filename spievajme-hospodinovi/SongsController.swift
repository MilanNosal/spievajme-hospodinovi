//
//  SongsController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class SongsController: UITableViewController {
    
    fileprivate let songController: SongController
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var songs: [Song]
    fileprivate var filteredSongs: [Song] = []
    
    init(style: UITableViewStyle, songs: [Song]) {
        
        self.songs = songs
        
        songController = SongController(style: .plain)
        
        super.init(style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.title = "Spievajme Hospodinovi"
        
    }
    
    func filterSongs(searchString: String?) {
        
        if let searchedString = searchString?.lowercased(), searchedString != "" {
            
            if Int(searchedString) != nil {
                filteredSongs = songs.filter({ (song) -> Bool in
                    return String(song.number).contains(searchedString)
                })
            } else {
                filteredSongs = songs.filter({ (song) -> Bool in
                    
                    if song.title!.lowercased().contains(searchedString) {
                        return true
                    }
                    
                    for verse in song.verses! {
                        let verse = verse as! Verse
                        let flattenedVerse = verse.lines!.map({ (line) -> String in
                            return (line as! Line).text!
                        }).joined(separator: " ").lowercased()
                        
                        if flattenedVerse.contains(searchedString) {
                            return true
                        }
                    }
                    
                    return false
                })
            }
        } else {
            filteredSongs = songs
        }
        tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredSongs.count
        } else {
            return songs.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier) as! SongCell
        
        let song: Song
        if searchController.isActive {
            song = filteredSongs[indexPath.row]
        } else {
            song = songs[indexPath.row]
        }
        
        cell.song = song
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchController.isActive {
            songController.song = filteredSongs[indexPath.row]
        } else {
            songController.song = songs[indexPath.row]
        }
        
        self.navigationController?.pushViewController(songController, animated: true)
        
    }
}

extension SongsController: UISearchResultsUpdating {
    
    func updateSearchResults(for: UISearchController) {
        filterSongs(searchString: searchController.searchBar.text)
    }
}
