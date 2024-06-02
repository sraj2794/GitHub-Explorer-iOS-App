//
//  Extension.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

extension UICollectionViewCell {
    static var identifier:String! {
        return String(describing: self)
    }
}
extension UITableViewCell {
    static var identifier:String! {
        return String(describing: self)
    }
}
extension UIViewController {
    static var identifier:String! {
        return String(describing: self)
    }
}


extension Array {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}
extension String {
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
}
extension UIImageView{
    
    func downloadImageWithURL(url: String){
        if let url = URL.init(string: url){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        self.image = UIImage.init(data: data!)
                    }
                }
            }.resume()
        }
    }
    
}
extension UITextField {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    
}
extension UIView {
    
    /// Add observer for keyboard
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    /// Remove Keyboard Observer
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK:- Keyboard Animation -
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        self.setNeedsLayout()
        UIView.animate(withDuration: TimeInterval(truncating: duration), delay: 0, options: [.curveEaseInOut], animations: {
            let info = notification.userInfo!
            let inputViewFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let screenSize = UIScreen.main.bounds
            var frame = self.frame
            frame.size.height = screenSize.height - inputViewFrame.size.height
            self.frame = frame
            
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        self.setNeedsLayout()
        UIView.animate(withDuration: TimeInterval(truncating: duration), delay: 0, options: [.curveEaseInOut], animations: {
            let screenSize = UIScreen.main.bounds
            var frame = self.frame
            frame.size.height = screenSize.height
            self.frame = frame
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
protocol ComponentShimmers {
    var animationDuration: Double { get }

    func hideViews()
    func showViews()
    func setShimmer()
    func removeShimmer()
}


/// For attaching custom views
extension UIView {
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setShadow(shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, offset: CGSize) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = offset
    }
    
    func setOpacity(to opacity: Float) {
        self.layer.opacity = opacity
    }
    
    func setBorder(with color: UIColor, _ width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
}
