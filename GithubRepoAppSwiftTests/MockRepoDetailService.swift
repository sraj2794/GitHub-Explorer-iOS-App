//
//  MockRepoDetailService.swift
//  GithubRepoAppSwiftTests
//
//  Created by Raj Shekhar on 02/06/24.
//

import Foundation
import XCTest
@testable import GithubRepoAppSwift

class MockRepoDetailService: RepositoryDetailServiceProtocol {
    
    var fetchPopularContributorsResult: Result<[Contributors], Error>!
    var fetchPopularCommentsResult: Result<[Comments], Error>!
    var fetchPopularIssuesResult: Result<[Issues], Error>!
    
    func fetchPopularContributors(loginName: String, name: String, completion: @escaping (Result<[Contributors], Error>) -> Void) {
        completion(fetchPopularContributorsResult)
    }
    
    func fetchPopularComments(loginName: String, name: String, completion: @escaping (Result<[Comments], Error>) -> Void) {
        completion(fetchPopularCommentsResult)
    }
    
    func fetchPopularIssues(loginName: String, name: String, completion: @escaping (Result<[Issues], Error>) -> Void) {
        completion(fetchPopularIssuesResult)
    }
}
