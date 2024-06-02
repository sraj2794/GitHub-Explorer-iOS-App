//
//	Contributors.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//
import Foundation

struct Contributors : Codable {
    
    let avatarUrl : String?
    let contributions : Int?
    let id : Int?
    let login : String?
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case contributions = "contributions"
        case id = "id"
        case login = "login"
    }
    
}
