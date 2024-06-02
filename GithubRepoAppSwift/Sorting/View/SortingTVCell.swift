//
//  SortingTVCell.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

class SortingTVCell: UITableViewCell {
    var secIdx: Int?
    
    @IBOutlet weak var selectionImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

