//
//	Issues.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//
import Foundation

struct Issues : Codable {
	let title : String?
	let updatedAt : String?
	let user : User?
	enum CodingKeys: String, CodingKey {
		case title = "title"
		case updatedAt = "updated_at"
		case user
	}
}
struct User : Codable {
    let avatarUrl : String?
    let login : String?
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login = "login"
    }
}
