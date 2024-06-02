//
//  RepoDetailViewModelTests.swift
//  GithubRepoAppSwiftTests
//
//  Created by Raj Shekhar on 02/06/24.
//

import XCTest
@testable import GithubRepoAppSwift

class RepoDetailViewModelTests: XCTestCase {
    
    var viewModel: RepoDetailViewModel!
    var mockRepoDetailService: MockRepoDetailService!
    
    override func setUp() {
        super.setUp()
        mockRepoDetailService = MockRepoDetailService()
        viewModel = RepoDetailViewModel(repoDetailService: mockRepoDetailService)
    }
    
    override func tearDown() {
        mockRepoDetailService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testGetPopularContributors_Success() {
        // Given
        let expectation = self.expectation(description: "Fetch popular contributors")
        let mockContributorsData = loadMockContributorsData()
        mockRepoDetailService.fetchPopularContributorsResult = .success(mockContributorsData)
        
        // When
        viewModel.getPopularContributors(loginName: "vsouza", name: "awesome-ios") {
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNotNil(self.viewModel.popularContributors.isEmpty)
            XCTAssertEqual(self.viewModel.popularContributors.count, mockContributorsData.count)
            // You can add more assertions here as needed
        }
    }
    
    func testGetPopularComments_Success() {
        // Given
        let expectation = self.expectation(description: "Fetch popular comments")
        let mockCommentsData = loadMockCommentsData()
        mockRepoDetailService.fetchPopularCommentsResult = .success(mockCommentsData)
        
        // When
        viewModel.getPopularComments(loginName: "vsouza", name: "awesome-ios") {
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNotNil(self.viewModel.popularComments.isEmpty)
            XCTAssertEqual(self.viewModel.popularComments.count, mockCommentsData.count)
            // You can add more assertions here as needed
        }
    }
    
    func testGetPopularIssues_Success() {
        // Given
        let expectation = self.expectation(description: "Fetch popular issues")
        let mockIssuesData = loadMockIssuesData()
        mockRepoDetailService.fetchPopularIssuesResult = .success(mockIssuesData)
        
        // When
        viewModel.getPopularIssues(loginName: "vsouza", name: "awesome-ios") {
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNotNil(self.viewModel.popularIssues.isEmpty)
            XCTAssertEqual(self.viewModel.popularIssues.count, mockIssuesData.count)
        }
    }
    
    private func loadMockIssuesData() -> [Issues] {
        let json = """
            [
              {
                "title": "add StringSwitch",
                "updatedAt": "2024-05-23T15:51:06Z",
                "user": {
                  "avatarUrl": "https://avatars.githubusercontent.com/u/7327521?v=4",
                  "login": "fabdurso"
                }
              }
            ]
        """
        guard let data = json.data(using: .utf8) else {
            fatalError("Failed to convert JSON string to data")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Issues].self, from: data)
        } catch {
            fatalError("Failed to decode JSON: \(error)")
        }
    }
    
    private func loadMockContributorsData() -> [Contributors] {
        let json = """
            [
              {
                "avatarUrl": "https://avatars.githubusercontent.com/u/6511079?v=4",
                "contributions": 1900,
                "id": 6511079,
                "login": "lfarah"
              }
            ]
        """
        guard let data = json.data(using: .utf8) else {
            fatalError("Failed to convert JSON string to data")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Contributors].self, from: data)
        } catch {
            fatalError("Failed to decode JSON: \(error)")
        }
    }
    
    private func loadMockCommentsData() -> [Comments] {
        let json = """
            [
              {
                "body": "thx",
                "user": {
                  "avatarUrl": "https://avatars.githubusercontent.com/u/4723115?v=4",
                  "login": "dkhamsing"
                }
              }
            ]
        """
        guard let data = json.data(using: .utf8) else {
            fatalError("Failed to convert JSON string to data")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Comments].self, from: data)
        } catch {
            fatalError("Failed to decode JSON: \(error)")
        }
    }
}
