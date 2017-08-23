//
//  NumpadViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 21/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import Foundation

import UIKit

let numpadNumberButtonSize = UIScreen.main.bounds.width / 5
let numpadNumberButtonsVerticalSpacing = UIScreen.main.bounds.width / 20

class NumberButton: UIButton {
    
    init(number: Int) {
        super.init(frame: CGRect.zero)
        
        self.tag = number
        
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = numpadNumberButtonSize / 2
        self.setTitleColor(.black, for: .normal)
        self.setTitle("\(number)", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: numpadNumberButtonSize / 2, weight: .light)
        
        self.setBackgroundColor(color: UIColor.white, for: .normal)
        self.setBackgroundColor(color: UIColor.black.withAlphaComponent(0.4), for: UIControlState.highlighted)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        [
            self.heightAnchor.constraint(equalToConstant: numpadNumberButtonSize),
            self.widthAnchor.constraint(equalToConstant: numpadNumberButtonSize),
        ].activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NumpadViewController: UIViewController {

    fileprivate var dismissalCallback: ((NumpadViewController) -> Void)?
    fileprivate var answeredCallback: ((NumpadViewController, Int) -> Void)?
    
    fileprivate let numberButtons: [NumberButton]
        = [NumberButton(number: 0), NumberButton(number: 1), NumberButton(number: 2),
           NumberButton(number: 3), NumberButton(number: 4), NumberButton(number: 5),
           NumberButton(number: 6), NumberButton(number: 7), NumberButton(number: 8),
           NumberButton(number: 9),
           NumberButton(number: 10) /* Delete button */]
    
    fileprivate let inputLabel = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
        
        view.layoutIfNeeded()
        
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(NumpadViewController.outsideTapHappening(sender:)))
        view.addGestureRecognizer(gr)
        
    }
    
    private func setupInitialHierarchy() {
        for button in numberButtons {
            view.addSubview(button)
        }
        view.addSubview(inputLabel)
        
    }
    
    private func setupInitialAttributes() {
        view.bounds = UIScreen.main.bounds
        view.layoutMargins = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        
        inputLabel.font = UIFont.systemFont(ofSize: numpadNumberButtonSize * 0.7, weight: .light)
        inputLabel.textColor = UIColor.black
        inputLabel.backgroundColor = .white
        inputLabel.layer.borderWidth = 2
        inputLabel.layer.borderColor = UIColor.black.cgColor
        inputLabel.layer.cornerRadius = 4
        inputLabel.textAlignment = .center
        
        inputLabel.text = ""
        
        numberButtons[10].setTitle("←", for: .normal)
//        numberButtons[10].setBackgroundColor(color: <#T##UIColor#>, for: <#T##UIControlState#>)
    }
    
    private func setupInitialLayout() {
        
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftVerticalGuide = UILayoutGuide()
        view.addLayoutGuide(leftVerticalGuide)
        let rightVerticalGuide = UILayoutGuide()
        view.addLayoutGuide(rightVerticalGuide)
        
        [
            leftVerticalGuide.leftAnchor.constraint(equalTo: view.leftAnchor),
            leftVerticalGuide.topAnchor.constraint(equalTo: view.topAnchor),
            leftVerticalGuide.rightAnchor.constraint(equalTo: view.centerXAnchor),
            leftVerticalGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rightVerticalGuide.leftAnchor.constraint(equalTo: view.centerXAnchor),
            rightVerticalGuide.topAnchor.constraint(equalTo: view.topAnchor),
            rightVerticalGuide.rightAnchor.constraint(equalTo: view.rightAnchor),
            rightVerticalGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            inputLabel.leftAnchor.constraint(equalTo: numberButtons[1].leftAnchor),
            inputLabel.rightAnchor.constraint(equalTo: numberButtons[3].rightAnchor),
            inputLabel.heightAnchor.constraint(equalToConstant: numpadNumberButtonSize * 0.85),
            inputLabel.bottomAnchor.constraint(equalTo: numberButtons[1].topAnchor, constant: -(numpadNumberButtonsVerticalSpacing * 2)),
            
            numberButtons[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberButtons[0].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(numpadNumberButtonsVerticalSpacing * 3)),
            
            numberButtons[10].centerXAnchor.constraint(equalTo: rightVerticalGuide.centerXAnchor),
            numberButtons[10].centerYAnchor.constraint(equalTo: numberButtons[0].centerYAnchor),
            
            numberButtons[1].centerXAnchor.constraint(equalTo: leftVerticalGuide.centerXAnchor),
            numberButtons[1].bottomAnchor.constraint(equalTo: numberButtons[4].topAnchor, constant: -numpadNumberButtonsVerticalSpacing),
            
            numberButtons[2].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberButtons[2].centerYAnchor.constraint(equalTo: numberButtons[1].centerYAnchor),
            
            numberButtons[3].centerXAnchor.constraint(equalTo: rightVerticalGuide.centerXAnchor),
            numberButtons[3].centerYAnchor.constraint(equalTo: numberButtons[1].centerYAnchor),
            
            numberButtons[4].centerXAnchor.constraint(equalTo: leftVerticalGuide.centerXAnchor),
            numberButtons[4].bottomAnchor.constraint(equalTo: numberButtons[7].topAnchor, constant: -numpadNumberButtonsVerticalSpacing),
            
            numberButtons[5].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberButtons[5].centerYAnchor.constraint(equalTo: numberButtons[4].centerYAnchor),
            
            numberButtons[6].centerXAnchor.constraint(equalTo: rightVerticalGuide.centerXAnchor),
            numberButtons[6].centerYAnchor.constraint(equalTo: numberButtons[4].centerYAnchor),
            
            numberButtons[7].centerXAnchor.constraint(equalTo: leftVerticalGuide.centerXAnchor),
            numberButtons[7].bottomAnchor.constraint(equalTo: numberButtons[0].topAnchor, constant: -numpadNumberButtonsVerticalSpacing),
            
            numberButtons[8].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberButtons[8].centerYAnchor.constraint(equalTo: numberButtons[7].centerYAnchor),
            
            numberButtons[9].centerXAnchor.constraint(equalTo: rightVerticalGuide.centerXAnchor),
            numberButtons[9].centerYAnchor.constraint(equalTo: numberButtons[7].centerYAnchor),
            
            
            ].activate()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

extension NumpadViewController {
    
    @objc func outsideTapHappening(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            if view.hitTest(sender.location(in: view), with: nil) === view {
                cancel(sender: sender)
            }
        }
        
    }
    
    func cancel(sender: Any?) {
        
        view.endEditing(true)
        
        self.dismissPresented(animated: true) {
            self.dismissalCallback?(self)
        }
    }
    
    
    func confirm(sender: Any?) {
        
        view.endEditing(true)
        
        self.dismissPresented(animated: true) {
            self.answeredCallback?(self, 1)
            self.dismissalCallback?(self)
        }
    }
}

extension NumpadViewController {
    
    fileprivate struct Static {
        
        static let window: UIWindow = {
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = RootViewController()
            window.windowLevel = UIWindowLevelAlert - 1
            return window
        }()
    }
    
    private class RootViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .clear
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
    }
    
    fileprivate func dismissPresented(animated: Bool = true, completion: @escaping () -> Void) {
        
        if animated {
            
            UIView.animate(withDuration: 0.25, animations: {
                () -> Void in
                self.view.alpha = 0
            }, completion: {
                (_) -> Void in
                
                DispatchQueue.main.async {
                    
                    Static.window.rootViewController?.dismiss(animated: false, completion: {
                        DispatchQueue.main.async {
                            Static.window.isHidden = Static.window.rootViewController!.presentedViewController == nil
                        }
                        
                        completion()
                    })
                }
            })
            
        } else {
            
            DispatchQueue.main.async {
                
                Static.window.rootViewController?.dismiss(animated: false, completion: {
                    DispatchQueue.main.async {
                        Static.window.isHidden = Static.window.rootViewController!.presentedViewController == nil
                    }
                    
                    completion()
                })
            }
        }
        lockOrientation(.allButUpsideDown)
    }
    
    static func dismissIfNeeded(animated: Bool, completion: @escaping (_ dismissed: Bool) -> Void) {
        
        if Static.window.rootViewController!.presentedViewController == nil || Static.window.rootViewController!.presentedViewController!.isBeingDismissed {
            completion(false)
        } else {
            
            let popup = Static.window.rootViewController!.presentedViewController as! NumpadViewController
            popup.dismissPresented(animated: animated, completion: {
                completion(true)
            })
        }
    }
    
    private static func present(
        animated: Bool = true,
        answeredCallback: ((NumpadViewController, Int) -> Void)?,
        dismissalCallback: ((NumpadViewController) -> Void)?,
        _ presentCompletionBlock: ((NumpadViewController) -> Void)?) {
        
        guard Static.window.rootViewController!.presentedViewController == nil || Static.window.rootViewController!.presentedViewController!.isBeingDismissed else {
            
            presentCompletionBlock?(Static.window.rootViewController!.presentedViewController as! NumpadViewController)
            return
        }
        
        let popup = NumpadViewController()
        
        popup.answeredCallback = answeredCallback
        popup.dismissalCallback = dismissalCallback
        
        if animated {
            
            popup.view.alpha = 0
            
            Static.window.isHidden = false
            Static.window.rootViewController!.present(popup, animated: false, completion: {
                
                UIView.animate(withDuration: 0.25, animations: {
                    () in
                    
                    popup.view.alpha = 1
                }, completion:  {
                    _ in
                    
                    _ = popup.becomeFirstResponder()
                })
                presentCompletionBlock?(popup)
            })
            
        } else {
            
            Static.window.isHidden = false
            Static.window.rootViewController!.present(popup, animated: false, completion: {
                
                _ = popup.becomeFirstResponder()
                presentCompletionBlock?(popup)
            })
            
        }
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    static func show(
        answeredCallback: ((NumpadViewController, Int) -> Void)?,
        dismissalCallback: ((NumpadViewController) -> Void)? = nil) {
        
        precondition(Thread.isMainThread)
        
        NumpadViewController.dismissIfNeeded(animated: true, completion: {
            (_) in
            
            NumpadViewController.present(
                answeredCallback: answeredCallback, dismissalCallback: dismissalCallback, nil)
        })
    }
    
}
