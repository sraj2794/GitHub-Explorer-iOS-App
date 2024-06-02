//
//  AppConstants.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import Foundation

struct EndPoints {
    static let githubRepoSearchApi = "https://api.github.com/search/repositories"
    static let topContributorsApi = "https://api.github.com/repos/%@/%@/contributors" //login/name/contributors
    static let topCommentsUrl = "https://api.github.com/repos/%@/%@/comments"
    static let topIssuesUrl = "https://api.github.com/repos/%@/%@/issues"
}
struct StringConstants {
    static let navTitle = "Github Repositories"
}
