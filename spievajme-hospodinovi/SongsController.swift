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
    fileprivate var favouritesOn: Bool = false
    
    fileprivate let allWithFavourite = #imageLiteral(resourceName: "toolbar_emptyHeart").withRenderingMode(.alwaysTemplate)
    fileprivate let onlyFavourite = #imageLiteral(resourceName: "toolbar_fullHeart").withRenderingMode(.alwaysTemplate)
    fileprivate var lastSong: Song?
    
    fileprivate var lastSongButton: UIBarButtonItem!
    
    fileprivate let quickSearch = QuickSearch(limit: (lower: 1, upper: 400))
    
    init(style: UITableViewStyle, songs: [Song]) {
        self.songs = songs
        self.filteredSongs = songs
        self.exampleSong = songs.first!
        songController = SongController()
        super.init(style: style)
        quickSearch.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "navigation_settingsEmpty").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(settingsSelected))
        
        let search = UIBarButtonItem(image: #imageLiteral(resourceName: "toolbar_searchThiner").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(searchSelected))
        let quickSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "toolbar_numpadEmpty").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(quickSearchPressed))
        let favourites = UIBarButtonItem(image: allWithFavourite, style: .plain, target: self, action: #selector(switchFavourites(_:)))
        lastSongButton = UIBarButtonItem(image: #imageLiteral(resourceName: "toolbar_lastSong").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(showLastSong))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbarItems = [favourites, spacer, spacer, spacer, search, spacer, spacer, spacer, quickSearch, spacer, spacer, spacer, lastSongButton]
        
        lastSongButton.isEnabled = false
        
        navigationController?.setToolbarHidden(false, animated: false)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    @objc fileprivate func switchFavourites(_ sender: UIBarButtonItem) {
        favouritesOn = !favouritesOn
        if favouritesOn {
            sender.image = onlyFavourite
        } else {
            sender.image = allWithFavourite
        }
        filterSongs(searchString: searchController.searchBar.text)
        if !filteredSongs.isEmpty {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    @objc fileprivate func showLastSong() {
        guard let lastSong = lastSong else {
            return
        }
        songController.songModel = SongModel(song: lastSong)
        self.navigationController?.pushViewController(songController, animated: true)
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
        
        filteredSongs = self.songs
        
        if favouritesOn {
            filteredSongs = filteredSongs.filter({ $0.isFavourite })
        }
        
        if let searchString = searchString?.uppercased().folding(options: .diacriticInsensitive, locale: Locale.current), searchString != "" {
            filteredSongs = filteredSongs.filter({ $0.isAccepted(bySearchString: searchString) })
        }
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSongs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier) as! SongCell
        
        let song: Song = filteredSongs[indexPath.row]
        cell.song = song
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        songController.songModel = SongModel(song: filteredSongs[indexPath.row])
        lastSong = filteredSongs[indexPath.row]
        lastSongButton.isEnabled = true
        
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
        lastSong = songs[number - 1]
        lastSongButton.isEnabled = true
        self.navigationController?.pushViewController(songController, animated: true)
    }
}
