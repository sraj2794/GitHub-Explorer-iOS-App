//
//  TitleCollectionViewCell.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//
import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    // MARK:- outlets for the cell
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: DownloadImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    // MARK:- variables for the cell
    override class func description() -> String {
        return "TitleCollectionViewCell"
    }
    
    let cellHeight: CGFloat = 240
    let cornerRadius: CGFloat = 12
    
    // MARK:- lifeCycle methods for the cell
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.setCornerRadius(radius: 12)
        self.userImageView.setCornerRadius(radius: 12)
        self.userImageView.setShadow(shadowColor: UIColor.label, shadowOpacity: 1, shadowRadius: 10, offset: CGSize(width: 0, height: 2))
        self.userImageView.setBorder(with: UIColor.label.withAlphaComponent(0.15), 2)
    }
    
    func setupContributorCell(listType:ListType, model: Contributors) {
        let contributor = model
        self.titleLabel.text = contributor.login
        self.subTitleLabel.text = String(contributor.contributions ?? 0)
        
        DispatchQueue.global().async {
            if URL(string:contributor.avatarUrl ?? "") != nil {
                self.userImageView.loadImageForUrl(url:contributor.avatarUrl ?? "")
            }
        }
    }
    
    func setupCommentsCell(listType:ListType, model: Comments) {
        let commenter = model
        self.titleLabel.text = commenter.user?.login
        self.subTitleLabel.text = commenter.body
         
        DispatchQueue.global().async {
            if URL(string:commenter.user?.avatarUrl ?? "") != nil {
                self.userImageView.loadImageForUrl(url:commenter.user?.avatarUrl ?? "")
            }
        }
    }
    
    func setupIssuesCell(listType:ListType, model: Issues) {
        let issues = model
        self.titleLabel.text = issues.title
        self.subTitleLabel.text = issues.user?.login
         
        DispatchQueue.global().async {
            if URL(string:issues.user?.avatarUrl ?? "") != nil {
                self.userImageView.loadImageForUrl(url:issues.user?.avatarUrl ?? "")
            }
        }
    }

}
