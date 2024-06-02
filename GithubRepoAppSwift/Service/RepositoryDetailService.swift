//
//  RepositoryDetailService.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import Foundation

protocol RepositoryDetailServiceProtocol {
    func fetchPopularContributors(loginName: String, name: String, completion: @escaping (Result<[Contributors], Error>) -> Void)
    func fetchPopularComments(loginName: String, name: String, completion: @escaping (Result<[Comments], Error>) -> Void)
    func fetchPopularIssues(loginName: String, name: String, completion: @escaping (Result<[Issues], Error>) -> Void)
}

final class RepositoryDetailService: RepositoryDetailServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchPopularContributors(loginName: String, name: String, completion: @escaping (Result<[Contributors], Error>) -> Void) {
        let apiRequest = String(format: EndPoints.topContributorsApi, loginName, name)
        guard let url = URL(string: apiRequest) else { return }
        networkManager.makeRequest(url: url, completion: completion)
    }
    
    func fetchPopularComments(loginName: String, name: String, completion: @escaping (Result<[Comments], Error>) -> Void) {
        let apiRequest = String(format: EndPoints.topCommentsUrl, loginName, name)
        guard let url = URL(string: apiRequest) else { return }
        networkManager.makeRequest(url: url, completion: completion)
    }
    
    func fetchPopularIssues(loginName: String, name: String, completion: @escaping (Result<[Issues], Error>) -> Void) {
        let apiRequest = String(format: EndPoints.topIssuesUrl, loginName, name)
        guard let url = URL(string: apiRequest) else { return }
        networkManager.makeRequest(url: url, completion: completion)
    }
}
