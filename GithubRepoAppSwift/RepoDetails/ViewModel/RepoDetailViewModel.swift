//
//  RepoDetailViewModel.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit
enum ListType {
    case contributorsList
    case commentsList
    case issuesList
}

class RepoDetailViewModel: NSObject {
    private let repoDetailService: RepositoryDetailServiceProtocol
    
    var popularContributors = [Contributors]()
    var popularComments = [Comments]()
    var popularIssues = [Issues]()
    
    init(repoDetailService: RepositoryDetailServiceProtocol) {
        self.repoDetailService = repoDetailService
    }

    // MARK:- variables for the viewModel
    func getCountForDisplay(type: ListType) -> Int {
        switch type {
        case .contributorsList:
            return min(popularContributors.count, 3)
        case .commentsList:
            return min(popularComments.count, 3)
        case .issuesList:
            return min(popularIssues.count, 3)
        }
    }

    func prepareCellForDisplay(collectionView: UICollectionView, type: ListType, indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .contributorsList:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.description(), for: indexPath) as? TitleCollectionViewCell {
                cell.setupContributorCell(listType: type, model: self.popularContributors[indexPath.item])
                return cell
            }
        case .commentsList:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.description(), for: indexPath) as? TitleCollectionViewCell {
                cell.setupCommentsCell(listType: type, model: self.popularComments[indexPath.item])
                return cell
            }
        case .issuesList:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.description(), for: indexPath) as? TitleCollectionViewCell {
                cell.setupIssuesCell(listType: type, model: self.popularIssues[indexPath.item])
                return cell
            }
        }
        fatalError()
    }
    
    // MARK:- functions for the viewModel
    func getPopularContributors(loginName: String, name: String, completion: @escaping () -> Void) {
        repoDetailService.fetchPopularContributors(loginName: loginName, name: name) { [weak self] result in
            switch result {
            case .success(let contributors):
                self?.popularContributors = contributors
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
    
    func getPopularComments(loginName: String, name: String, completion: @escaping () -> Void) {
        repoDetailService.fetchPopularComments(loginName: loginName, name: name) { [weak self] result in
            switch result {
            case .success(let comments):
                self?.popularComments = comments
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
    
    func getPopularIssues(loginName: String, name: String, completion: @escaping () -> Void) {
        repoDetailService.fetchPopularIssues(loginName: loginName, name: name) { [weak self] result in
            switch result {
            case .success(let issues):
                self?.popularIssues = issues
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
}
