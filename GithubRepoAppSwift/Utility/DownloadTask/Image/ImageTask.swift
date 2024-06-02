//
//  ImageTask.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//
import UIKit

let imageCache = NSCache<NSString, UIImage>()

protocol ImageTaskDownloadedDelegate:class {
    func imageDownloaded(url: String,image:UIImage)
    func failedDownload(url: String)
}

class ImageTask {
    let url: URL
    let session: URLSession
    var observers = [ImageTaskDownloadedDelegate]()
        
    private var task: URLSessionDownloadTask?
    private var resumeData: Data?
    private var isDownloading = false
    private var isFinishedDownloading = false

    init(url: URL) {
        self.url = url
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }

    func resume() {
        
        if !isDownloading && !isFinishedDownloading {
            isDownloading = true
            if let resumeData = resumeData {
                task = session.downloadTask(withResumeData: resumeData, completionHandler: downloadTaskCompletionHandler)
            } else {
                task = session.downloadTask(with: url, completionHandler: downloadTaskCompletionHandler)
            }
            task?.resume()
        }
    }
    
    func pause() {
        if isDownloading && !isFinishedDownloading {
            task?.cancel(byProducingResumeData: { (data) in
                self.resumeData = data
            })
            self.isDownloading = false
        }
    }
    
    func updateToObservers(image:UIImage) {
        for delgate in self.observers {
            delgate.imageDownloaded(url:self.url.absoluteString, image:image)
        }
    AppImageDownloadManager.imageDownloaderList.removeValue(forKey:self.url.absoluteString)
    }
    
    private func downloadTaskCompletionHandler(url: URL?, response: URLResponse?, error: Error?) {
        if let error = error {
            print("Error downloading: ", error)
            DispatchQueue.main.async {
                for delgate in self.observers {
                   delgate.failedDownload(url:self.url.absoluteString)
                }
            }
            return
        }
        
        guard let url = url else { return }
        guard let data = FileManager.default.contents(atPath: url.path) else { return }
        guard let image = UIImage(data: data) else { return }
        
        DispatchQueue.main.async {
            imageCache.setObject(image, forKey:self.url.absoluteString as NSString)
            self.updateToObservers(image:image)
        }
        
        self.isFinishedDownloading = true
    }
}
