//
//  GithubRepoModel.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import Foundation
struct GithubRepoModel: Codable {
    let incompleteResults: Bool?
    let items: [Item]?
    let totalCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case items
        case totalCount = "total_count"
    }
    
    init(incompleteResults: Bool?, items: [Item]?, totalCount: Int?) {
        self.incompleteResults = incompleteResults
        self.items = items
        self.totalCount = totalCount
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        incompleteResults = try values.decodeIfPresent(Bool.self, forKey: .incompleteResults)
        items = try values.decodeIfPresent([Item].self, forKey: .items)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
    }
}

struct Item: Codable {
    let owner: Owner?
    let id: Int?
    let name: String?
    let descriptionField: String?
    let issueCommentUrl: String?
    let commentsUrl: String?
    let contributorsUrl: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case owner
        case id = "id"
        case name = "name"
        case commentsUrl = "comments_url"
        case contributorsUrl = "contributors_url"
        case createdAt = "created_at"
        case issueCommentUrl = "issue_comment_url"
        case descriptionField = "description"
    }
}

struct Owner: Codable {
    let avatarUrl: String?
    let login: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id = "id"
        case login = "login"
    }
}

enum Sorting: String {
    case forks = "forks"
    case stars = "stars"
    case updated_at = "updated_at"
    case help_wanted = "help-wanted-issues"
}

//struct GithubRepoModel : Codable {
//
//    let incompleteResults : Bool?
//    let items : [Item]?
//    let totalCount : Int?
//    enum CodingKeys: String, CodingKey {
//        case incompleteResults = "incomplete_results"
//        case items
//        case totalCount = "total_count"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        incompleteResults = try values.decodeIfPresent(Bool.self, forKey: .incompleteResults)
//        items = try values.decodeIfPresent([Item].self, forKey: .items)
//        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
//    }
//
//}
//struct Item : Codable {
//    let owner : Owner?
//    let id : Int?
//    let name : String?
//    let descriptionField : String?
//    let issueCommentUrl : String?
//    let commentsUrl : String?
//    let contributorsUrl : String?
//    let createdAt : String?
//    enum CodingKeys: String, CodingKey {
//        case owner
//        case id = "id"
//        case name = "name"
//        case commentsUrl = "comments_url"
//        case contributorsUrl = "contributors_url"
//        case createdAt = "created_at"
//        case issueCommentUrl = "issue_comment_url"
//        case descriptionField = "description"
//    }
//
//}
//struct Owner : Codable {
//    let avatarUrl : String?
//    let login : String?
//    let id : Int?
//    enum CodingKeys: String, CodingKey {
//        case avatarUrl = "avatar_url"
//        case id = "id"
//        case login = "login"
//    }
//}
//
//enum Sorting:String{
//    case forks = "forks"
//    case stars = "stars"
//    case updated_at = "updated_at"
//    case help_wanted = "help-wanted-issues"
//}
