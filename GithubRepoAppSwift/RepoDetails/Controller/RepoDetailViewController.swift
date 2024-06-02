//
//  RepoDetailViewController.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var contributorsCollectionView: UICollectionView!
    @IBOutlet weak var commentsCollectionView: UICollectionView!
    @IBOutlet weak var issuesCollectionView: UICollectionView!
    @IBOutlet weak var issuesStackView: UIStackView!
    
    // MARK:- variables for the viewController
    override class func description() -> String {
        "RepoDetailViewController"
    }
    var favoriteMoviesStackHeight: CGFloat = 0
    var visiblePaths: [IndexPath] = [IndexPath]()
    var repoDetailViewModel: RepoDetailViewModel!
    var loginName: String = ""
    var repoName: String = ""
    
    // MARK:- lifeCycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        let repoDetailService = RepositoryDetailService(networkManager: networkManager)
        repoDetailViewModel = RepoDetailViewModel(repoDetailService: repoDetailService)
        
        setCollectionView(for: contributorsCollectionView, with: TitleCollectionViewCell().asNib(), and: TitleCollectionViewCell.description())
        setCollectionView(for: commentsCollectionView, with: TitleCollectionViewCell().asNib(), and: TitleCollectionViewCell.description())
        setCollectionView(for: issuesCollectionView, with: TitleCollectionViewCell().asNib(), and: TitleCollectionViewCell.description())
        
        favoriteMoviesStackHeight = issuesStackView.frame.height
        callingAPIS()
    }
    
    // MARK:- functions for the viewController
    func setCollectionView(for collectionView: UICollectionView, with nib: UINib, and identifier: String) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension RepoDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case contributorsCollectionView:
            return repoDetailViewModel.getCountForDisplay(type: .contributorsList)
        case commentsCollectionView:
            return repoDetailViewModel.getCountForDisplay(type: .commentsList)
        case issuesCollectionView:
            return repoDetailViewModel.getCountForDisplay(type: .issuesList)
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case contributorsCollectionView:
            return repoDetailViewModel.prepareCellForDisplay(collectionView: collectionView, type: .contributorsList, indexPath: indexPath)
        case commentsCollectionView:
            return repoDetailViewModel.prepareCellForDisplay(collectionView: collectionView, type: .commentsList, indexPath: indexPath)
        case issuesCollectionView:
            return repoDetailViewModel.prepareCellForDisplay(collectionView: collectionView, type: .issuesList, indexPath: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.getSizeForHorizontalCollectionView(columns: 2.4, height: TitleCollectionViewCell().cellHeight)
    }
}

// MARK: - API Request and Response Handler
extension RepoDetailViewController {
    func callingAPIS() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        repoDetailViewModel.getPopularContributors(loginName: loginName, name: repoName) { [weak self] in
            DispatchQueue.main.async {
                self?.contributorsCollectionView.reloadData()
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        repoDetailViewModel.getPopularComments(loginName: loginName, name: repoName) { [weak self] in
            DispatchQueue.main.async {
                self?.commentsCollectionView.reloadData()
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        repoDetailViewModel.getPopularIssues(loginName: loginName, name: repoName) { [weak self] in
            DispatchQueue.main.async {
                self?.issuesCollectionView.reloadData()
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.contributorsCollectionView.reloadData()
            self.commentsCollectionView.reloadData()
            self.issuesCollectionView.reloadData()
        }
    }
}
