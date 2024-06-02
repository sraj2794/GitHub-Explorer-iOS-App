//
//  RepoListViewModel.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

class RepoListViewModel {
    var githubRepoList: [Item] = []
    var sortingItem: [Sorting] = [.forks, .help_wanted, .stars, .updated_at]
    var error: Error?
    
    private let repoService: RepoServiceProtocol
    
    init(repoService: RepoServiceProtocol = RepoService()) {
        self.repoService = repoService
    }
    
    func searchRepos(withText text: String = "Swift", offset: Int, limit: Int, sortBy: Sorting = .stars, completion: @escaping (Result<Void, Error>) -> Void) {
        repoService.searchRepositories(query: text, sortBy: sortBy, offset: offset, limit: limit) { result in
            switch result {
            case .success(let dataList):
                if offset == 0 {
                    self.githubRepoList.removeAll()
                }
                self.githubRepoList.append(contentsOf: dataList.items ?? [])
                self.error = nil
                completion(.success(())) // Call completion with success
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.error = error
                completion(.failure(error)) // Call completion with failure and error
            }
        }
    }
}
