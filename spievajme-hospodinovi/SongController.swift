//
//  SongController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class SongController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate let tableView = UITableView(frame: CGRect.zero, style: .plain)
    fileprivate let emptyCell = EmptyCell()
    
    fileprivate var favouriteButton: UIBarButtonItem?
    fileprivate let emptyStar = #imageLiteral(resourceName: "navigation_starEmpty").withRenderingMode(.alwaysTemplate)
    fileprivate let fullStar = #imageLiteral(resourceName: "navigation_starFilled").withRenderingMode(.alwaysTemplate)
    
    
    fileprivate var isFavourite = false {
        didSet {
            updateIsFavourite()
        }
    }
    
    var songModel: SongModel? {
        didSet {
            if let songModel = songModel {
                if songModel.songNumber != oldValue?.songNumber {

                    self.isFavourite = songModel.song.isFavourite
                    
                    self.navigationItem.title = songModel.songTitle
                    
                    self.tableView.reloadData()
                    
                    DispatchQueue.main.async {
                        if self.tableView(self.tableView, numberOfRowsInSection: 0) > 0 {
                            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 11.0, *) {
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        }
        
        [
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ].activate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteButton = UIBarButtonItem(image: emptyStar, style: .plain, target: self, action: #selector(favouriteSwitched))
        navigationItem.rightBarButtonItem = favouriteButton
        
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
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lockOrientation(.allButUpsideDown)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    fileprivate func updateIsFavourite() {
        if self.isFavourite {
            favouriteButton?.image = fullStar
        } else {
            favouriteButton?.image = emptyStar
        }
    }
    
    @objc fileprivate func favouriteSwitched() {
        self.isFavourite = !self.isFavourite
        SongStoreCoreData.shared.performUpdates {
            self.songModel?.song.isFavourite = self.isFavourite
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return songModel?.verses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let versesCount = songModel?.verses.count,
            section == versesCount - 1 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = songModel?.verses[section].title ?? ""
        let view = VerseHeaderView()
        view.header = title
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let versesCount = songModel?.verses.count,
            indexPath.section == versesCount - 1,
            indexPath.row == 1 {
            return emptyCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: VerseCell.identifier) as! VerseCell
        cell.verse = songModel?.verses[indexPath.section].text ?? ""
        cell.setupFontScheme()
        return cell
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
