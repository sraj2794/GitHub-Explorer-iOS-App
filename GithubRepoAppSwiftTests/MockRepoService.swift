//
//  MockRepoService.swift
//  GithubRepoAppSwiftTests
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit
import XCTest
@testable import GithubRepoAppSwift

class MockRepoService: RepoServiceProtocol {
    enum MockResult {
        case success(GithubRepoModel)
        case failure(Error)
    }
    
    var mockResult: MockResult = .success(GithubRepoModel(incompleteResults: false, items: [], totalCount: 0))
    
    func searchRepositories(query: String, sortBy: Sorting, offset: Int, limit: Int, completion: @escaping (Result<GithubRepoModel, Error>) -> Void) {
        switch mockResult {
        case .success(let githubRepoModel):
            completion(.success(githubRepoModel))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

enum MockError: Error {
    case someError
}
