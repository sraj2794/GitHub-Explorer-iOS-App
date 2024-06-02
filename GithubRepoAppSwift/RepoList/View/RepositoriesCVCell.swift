//
//  RepositoriesCVCell.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

class RepositoriesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var repoDetailLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: DownloadImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        self.thumbnailImageView.makeImageViewReusable()
        self.activityIndicator.stopAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 6
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.borderColor = CGColor(srgbRed: 255/255, green: 207/255, blue: 220/255, alpha: 1)
        self.layer.cornerRadius = 12
    }
    
    func updateCell(cellData: Item) {
        repoDetailLabel.text = cellData.descriptionField
        repoNameLabel.text = cellData.name
    }
    
    func loadImage(url: String) {
        if let _ = URL(string: url) {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            self.thumbnailImageView.delegate = self
            self.thumbnailImageView.loadImageForUrl(url: url)
        }
    }
}

extension RepositoriesCVCell: ImageViewUpdatedDelegate {
    func imageUpdated() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
