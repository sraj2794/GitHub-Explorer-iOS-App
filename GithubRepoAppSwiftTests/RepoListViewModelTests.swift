//
//  RepoListViewModelTests.swift
//  GithubRepoAppSwiftTests
//
//  Created by Raj Shekhar on 02/06/24.
//

import XCTest
@testable import GithubRepoAppSwift

class RepoListViewModelTests: XCTestCase {
    
    var viewModel: RepoListViewModel!
    var mockRepoService: MockRepoService!
    var mockGithubRepoItem: [Item]!
    
    override func setUp() {
        super.setUp()
        mockRepoService = MockRepoService()
        viewModel = RepoListViewModel(repoService: mockRepoService)
        mockGithubRepoItem = loadMockGithubRepoItem()
    }
    
    override func tearDown() {
        mockRepoService = nil
        viewModel = nil
        mockGithubRepoItem = nil
        super.tearDown()
    }
    
    private func loadMockGithubRepoItem() -> [Item] {
        let json = """
        {
            "total_count": 1320724,
            "incomplete_results": false,
            "items": [
                {
                    "id": 21700699,
                    "name": "awesome-ios",
                    "owner": {
                        "login": "vsouza",
                        "avatar_url": "https://avatars.githubusercontent.com/u/484656?v=4"
                    },
                    "description": "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects",
                    "created_at": "2014-07-10T16:03:45Z"
                }
            ]
        }
        """
        let data = Data(json.utf8)
        let githubRepoData = try! JSONDecoder().decode(GithubRepoModel.self, from: data)
        return githubRepoData.items!
    }
    
    func testSearchRepos_Success() {
        // Given
        let expectation = self.expectation(description: "Search repos completion")
        
        // When
        mockRepoService.mockResult = .success(GithubRepoModel(incompleteResults: false, items: mockGithubRepoItem, totalCount: mockGithubRepoItem.count))
        viewModel.searchRepos(withText: "Swift", offset: 0 , limit: 10) { result in
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.githubRepoList.count, self.mockGithubRepoItem.count)
            XCTAssertEqual(self.viewModel.githubRepoList.first?.name, self.mockGithubRepoItem.first?.name)
        }
    }
    
    func testSearchRepos_Failure() {
        // Given
        let expectation = self.expectation(description: "Search repos completion")
        
        // When
        mockRepoService.mockResult = .failure(MockError.someError)
        viewModel.searchRepos(withText: "Swift", offset: 0 , limit: 10) { result in
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNotNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.githubRepoList.count, 0)
        }
    }
}
