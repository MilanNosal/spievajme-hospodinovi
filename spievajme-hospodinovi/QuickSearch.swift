//
//  QuickSearch.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 27/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

protocol QuickSearchDelegate: class {
    func quickSearchDidSelect(number: Int)
}

class QuickSearch: NSObject, UITextFieldDelegate {
    
    weak var delegate: QuickSearchDelegate?
    
    fileprivate var submitAction: UIAlertAction?
    
    fileprivate let limit: (lower: Int, upper: Int)
    
    init(limit: (lower: Int, upper: Int)) {
        self.limit = limit
        super.init()
    }
    
    func present(in viewController: UIViewController) {
        let quickSearchController = UIAlertController(title: "Skoč na pieseň", message: "Zadajte číslo piesne (\(limit.lower) - \(limit.upper)", preferredStyle: .alert)
        quickSearchController.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.delegate = self
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            self.submitAction = nil
        })
        submitAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.submitPressed(controller: quickSearchController, presentedBy: viewController)
            self.submitAction = nil
        })
        submitAction!.isEnabled = false
        quickSearchController.addAction(cancel)
        quickSearchController.addAction(submitAction!)
        viewController.present(quickSearchController, animated: true, completion: nil)
    }
    
    fileprivate func submitPressed(controller: UIAlertController, presentedBy: UIViewController) {
        guard let textField = controller.textFields?.first,
            let text = textField.text,
            let number = Int(text) else {
                controller.dismiss(animated: true, completion: nil)
            return
        }
        
        if number == 1987 {
            controller.dismiss(animated: true, completion: {
                self.easterEgg(in: presentedBy)
            })
        } else if number >= limit.lower && number <= limit.upper {
            delegate?.quickSearchDidSelect(number: number)
        } else {
            fatalError()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let proposedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string),
            let number = Int(proposedString),
            (number >= limit.lower && number <= limit.upper) || number == 1987 {
            submitAction?.isEnabled = true
        } else {
            submitAction?.isEnabled = false
        }
        
        return true
    }
}

extension QuickSearch {
    fileprivate func easterEgg(in viewController: UIViewController) {
        // TODO
    }
}
