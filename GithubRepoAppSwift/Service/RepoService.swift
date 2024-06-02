//
//  RepoService.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import Foundation

protocol RepoServiceProtocol {
    func searchRepositories(query: String, sortBy: Sorting, offset: Int, limit: Int, completion: @escaping (Result<GithubRepoModel, Error>) -> Void)
}

class RepoService: RepoServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    // Assume this method implementation calls the actual API
    func searchRepositories(query: String, sortBy: Sorting, offset: Int, limit: Int, completion: @escaping (Result<GithubRepoModel, Error>) -> Void) {
        let apiRequest = EndPoints.githubRepoSearchApi
        guard var urlComponents = URLComponents(string: apiRequest) else { return }
        let language = URLQueryItem(name: "q", value: "language:\(query)")
        let sortBy = URLQueryItem(name: "sort", value: sortBy.rawValue)
        let order = URLQueryItem(name: "order", value: "desc")
        let offsetNo = URLQueryItem(name: "page", value: String(offset))
        let limit = URLQueryItem(name: "per_page", value: String(limit))
        urlComponents.queryItems = [language, sortBy, order, limit, offsetNo]
        
        guard let url = urlComponents.url else { return }
        
        networkManager.makeRequest(url: url) { (result: Result<GithubRepoModel, Error>) in
            completion(result)
        }

    }
}

extension URLRequest {
    
    /**
     Returns a cURL command representation of this URL request.
     */
    public var cURLString: String {
        guard let url = url else { return "" }
#if swift(>=5.0)
        var baseCommand = #"curl "\#(url.absoluteString)""#
#else
        var baseCommand = "curl \"\(url.absoluteString)\""
#endif
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
    
}
