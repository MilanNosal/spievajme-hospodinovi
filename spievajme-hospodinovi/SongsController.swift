//
//  SongsController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class SongsController: SHTableViewController {
    
    fileprivate let songController: SongController
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let songs: [Song]
    fileprivate let exampleSong: Song
    fileprivate var filteredSongs: [Song] = []
    
    fileprivate let quickSearch = QuickSearch(limit: (lower: 1, upper: 400))
    
    init(style: UITableViewStyle, songs: [Song]) {
        self.songs = songs
        self.exampleSong = songs.first!
        songController = SongController()
        super.init(style: style)
        quickSearch.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSettings() {
        super.setupSettings()
        songController.songModel = nil
    }
    
    override func setupFontScheme() {
        super.setupFontScheme()
        songController.songModel = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Hľadať"
        searchController.searchBar.setValue("Zrušiť", forKey:"_cancelButtonText")
        
        definesPresentationContext = true
        
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.title = "Spievajme Hospodinovi"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Späť", style: .plain, target: nil, action: nil)
        
        setupToolbar()
    }
    
    fileprivate func setupToolbar() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settingsEmpty").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(settingsSelected))
        
        let search = UIBarButtonItem(image: #imageLiteral(resourceName: "searchThiner").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(searchSelected))
        let quickSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "numpadEmpty").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(quickSearchPressed))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbarItems = [search, spacer, spacer, spacer, spacer, spacer, spacer, spacer, spacer, spacer, spacer, spacer, quickSearch]
        
        navigationController?.setToolbarHidden(false, animated: false)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    @objc fileprivate func settingsSelected() {
        let settingsController = SettingsViewController(style: .grouped)
        settingsController.exampleSong = self.exampleSong
        let navController = UINavigationController(rootViewController: settingsController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func searchSelected() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        searchController.searchBar.becomeFirstResponder()
    }
    
    @objc fileprivate func quickSearchPressed() {
        quickSearch.present(in: self)
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
            songController.songModel = SongModel(song: filteredSongs[indexPath.row])
        } else {
            songController.songModel = SongModel(song: songs[indexPath.row])
        }
        
        self.navigationController?.pushViewController(songController, animated: true)
        
    }
}

extension SongsController: UISearchResultsUpdating {
    
    func updateSearchResults(for: UISearchController) {
        filterSongs(searchString: searchController.searchBar.text)
    }
}

extension SongsController: QuickSearchDelegate {
    func quickSearchDidSelect(number: Int) {
        songController.songModel = SongModel(song: songs[number - 1])
        self.navigationController?.pushViewController(songController, animated: true)
    }
}
