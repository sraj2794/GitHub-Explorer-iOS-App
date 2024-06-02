//
//  InitialPopupView.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

protocol InitialPopupDelegate: AnyObject {
    func closeButtonTapped()
    func doneButtonSelected(name:String)
}

class InitialPopupView: UIView {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var programmingLabel: UILabel!
    @IBOutlet weak var programmingTextField: UITextField!
    @IBOutlet weak var subViewTopConstraint: NSLayoutConstraint!

    weak var delegate: InitialPopupDelegate? = nil

    @IBAction func closeButtonAction(_ sender: Any) {
        self.removeViewWithAnimation()
    }

    @IBAction func doneButtonAction(_ sender: Any) {
        self.endEditing(true)
        
        // Trim leading and trailing whitespaces
        let languageName = self.programmingTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if !languageName.isEmpty {
            self.removeViewWithAnimation()
            self.delegate?.doneButtonSelected(name: languageName)
        } else {
            self.programmingTextField.shake()
        }
    }

    func removeViewWithAnimation() {
        var frameForAnimation = self.bounds
        frameForAnimation.origin.y = 0
        self.frame = frameForAnimation
        self.layoutIfNeeded()
        removeObserver()
        self.subView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.1, animations: {
            self.subView.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
        }, completion: { (finished) in
            if finished {
                self.alpha = 1.0
                UIView.animate(withDuration: 0.5, animations: {
                    self.alpha = 0
                    self.subView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                }, completion: { (finished) in
                    if finished {
                        self.removeFromSuperview()
                    }
                })
            }
        })
    }

    ///  when user touches view textField editing is ended.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    /// method to load reasons xib.
    func loadInitialPopUpView() {
        // Initial PopUp name of the XIB.
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        addObserver()
        self.subViewTopConstraint.constant = 0
        self.titleLabel.text = "Welcome!"
        programmingTextField.placeholder = "Swift, Java, Python, etc."
        self.frame = self.bounds
        self.addSubview(subView)
        self.layoutIfNeeded()
        var frameForAnimation = self.subView.frame
        frameForAnimation.origin.y = -900
        self.subView.frame = frameForAnimation
        self.subView.layoutIfNeeded()

        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            frameForAnimation.origin.y = 0
            self.subView.frame = frameForAnimation
        }, completion: { (finished) in
            if finished {
                
            }
        })
    }
}

extension InitialPopupView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.programmingTextField.resignFirstResponder()
        self.subViewTopConstraint.constant = 0
        return true
    }
}
