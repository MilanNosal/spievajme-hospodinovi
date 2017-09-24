//
//  EasterEggPhotoCollectionViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 02/09/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//


import UIKit

class EasterEggPhotoCollectionViewController: UIViewController {
    
    fileprivate let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    fileprivate let photoControllers = [EasterEggPhotoViewController(photo: #imageLiteral(resourceName: "Tonik_1")),
                                        EasterEggPhotoViewController(photo: #imageLiteral(resourceName: "Tonik_2")),
                                        EasterEggPhotoViewController(photo: #imageLiteral(resourceName: "Tonik_3")),
                                        EasterEggPhotoViewController(photo: #imageLiteral(resourceName: "Tonik_4")),
                                        EasterEggPhotoViewController(photo: #imageLiteral(resourceName: "Tonik_5")),
                                        EasterEggPhotoViewController(photo: #imageLiteral(resourceName: "Tonik_6"))]
    
    fileprivate var selectedPhoto = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
    }
    
    fileprivate func setupInitialHierarchy() {
        view.addSubview(pageViewController.view)
    }
    
    fileprivate func setupInitialAttributes() {
        
        self.view.backgroundColor = UIColor.white
        
        self.title = "Tonik"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(closeSelf))
        
        
        pageViewController.view.backgroundColor = UIColor.white
        pageViewController.dataSource = self
        pageViewController.setViewControllers([photoControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    @objc fileprivate func closeSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupInitialLayout() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        [
            pageViewController.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            pageViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ].activate()
    }
}

extension EasterEggPhotoCollectionViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let indexOfVC = (photoControllers.index(of: viewController as! EasterEggPhotoViewController))!
        if indexOfVC >= photoControllers.count - 1 {
            return nil
        } else {
            return photoControllers[indexOfVC + 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let indexOfVC = (photoControllers.index(of: viewController as! EasterEggPhotoViewController))!
        if indexOfVC <= 0 {
            return nil
        } else {
            return photoControllers[indexOfVC - 1]
        }
    }
}
