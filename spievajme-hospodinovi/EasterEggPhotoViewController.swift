//
//  EasterEggPhotoViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 02/09/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class EasterEggPhotoViewController: UIViewController {
    fileprivate let photoView: UIImageView = UIImageView()
    
    init(photo: UIImage) {
        super.init(nibName: nil, bundle: nil)
        photoView.image = photo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
    }
    
    fileprivate func setupInitialHierarchy() {
        view.addSubview(photoView)
    }
    
    fileprivate func setupInitialAttributes() {
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        self.view.backgroundColor = UIColor.white
    }
    
    fileprivate func setupInitialLayout() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.constraintsFittingToSuperview().activate()
    }
}
