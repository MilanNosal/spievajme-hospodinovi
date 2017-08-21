//
//  LoadingController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/07/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {
    
    fileprivate let backgroundImageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "cover"))
    
    fileprivate let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    fileprivate let statusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
    }
    
    fileprivate func setupInitialHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(activityIndicator)
        view.addSubview(statusLabel)
    }
    
    fileprivate func setupInitialAttributes() {
        view.backgroundColor = UIColor.white
        
        backgroundImageView.contentMode = .scaleAspectFit
        
        activityIndicator.hidesWhenStopped = true
        
        statusLabel.textColor = UIColor.white
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
    }
    
    fileprivate func setupInitialLayout() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8),
            statusLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            statusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ].activate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadSongs()
    }
    
    fileprivate func loadSongs() {
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            
            if !SongStoreCoreData.shared.isLoaded() {
                DispatchQueue.main.async {
                    self.statusLabel.text = "Inicializujem databázu..."
                }
                
                let songs = parseSongsFromArchive()
            
                SongStoreCoreData.shared.persist(from: songs, completion: { (songs) in
                    DispatchQueue.main.async {
                        
                        self.activityIndicator.stopAnimating()
                        self.statusLabel.text = ""
                        
                        self.finish(loadedSongs: songs)
                    }
                })
            } else {
                DispatchQueue.main.async {
                    self.statusLabel.text = "Načítavam spevník..."
                }
                
                let songs = SongStoreCoreData.shared.getAllSongs()
                
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                    self.statusLabel.text = ""
                    
                    self.finish(loadedSongs: songs)
                }
            }
        }
        
    }
    
    fileprivate func finish(loadedSongs: [Song]) {
        
        let songsController = SongsController(style: .plain, songs: loadedSongs)
        let navController = UINavigationController(rootViewController: songsController)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundImageView.alpha = 0
        }) { _ in
            UIApplication.shared.keyWindow?.rootViewController = navController
        }
    }
}
