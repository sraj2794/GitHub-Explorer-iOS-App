//
//	Comments.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//
import Foundation

struct Comments : Codable {
	let body : String?
	let user : User?
	enum CodingKeys: String, CodingKey {
		case body = "body"
		case user
	}
}
struct UserComments : Codable {
    let avatarUrl : String?
    let login : String?
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login = "login"
    }
}
