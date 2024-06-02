//
//  AppImageDownloadManager.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//
import UIKit

protocol ImageViewUpdatedDelegate: AnyObject {
    func imageUpdated()
}

class DownloadImageView: UIImageView {
    var imageURL: String?
    var imageTask: ImageTask?
    weak var delegate: ImageViewUpdatedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func set(image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
            self.delegate?.imageUpdated()
        }
    }
    
    func makeImageViewReusable() {
        self.imageTask?.pause()
        self.imageURL = ""
        self.image = nil
        self.delegate = nil
    }
    
    func loadImageForUrl(url: String) {
        imageURL = url
        if let hasImage = AppImageDownloadManager.getImage(url: url) {
            self.set(image: hasImage)
        } else {
            imageTask = AppImageDownloadManager.createImageTask(url: url)
            imageTask?.observers.append(self)
            imageTask?.resume()
        }
    }
}

extension DownloadImageView: ImageTaskDownloadedDelegate {
    func imageDownloaded(url: String, image: UIImage) {
        if self.imageURL == url {
            self.set(image: image)
        }
    }
    
    func failedDownload(url: String) {
        if self.imageURL == url {
            DispatchQueue.main.async {
                self.delegate?.imageUpdated()
            }
        }
    }
}
class AppImageDownloadManager {
    static var imageDownloaderList = [String:ImageTask]()
    
    static func getImage(url:String) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: url as NSString){
            return cachedImage
        }
        return nil
    }
    
    static func createImageTask(url:String) -> ImageTask{
        if let task = AppImageDownloadManager.imageDownloaderList[url] {
            return task
        }
        let newTask = ImageTask(url:URL(string:url)!)
        AppImageDownloadManager.imageDownloaderList[url] = newTask
        return newTask
    }
}
