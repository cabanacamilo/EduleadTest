//
//  APIManager.swift
//  EduleadTest
//
//  Created by Camilo Cabana on 2/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class APIManager {
    
    var task: URLSessionTask?
    
    func downloadRepositories(searchWord: String, complition: @escaping(Result<[Repository], RepositoryError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)") else { return }
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                complition(.failure(.noDataAvailable))
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    let items = json?["items"] as? NSArray
                    let repositories = self.getRepositories(repositories: items)
                    complition(.success(repositories))
                } catch {
                    complition(.failure(.cannotProccesData))
                }
            }
        }
        task?.resume()
    }
    
    func getRepositories(repositories: NSArray?) -> [Repository] {
        var getRepositories = [Repository]()
        if let repositories = repositories {
            for i in repositories {
                let repository = i as? NSDictionary
                let fullName = repository?["full_name"] as? String ?? ""
                let language = repository?["language"] as? String ?? ""
                let stars = repository?["stargazers_count"] as? Int ?? 0
                let wachers = repository?["wachers_count"] as? Int ?? 0
                let forks = repository?["forks_count"] as? Int ?? 0
                let issues = repository?["open_issues_count"] as? Int ?? 0
                let owner = repository?["owner"] as? NSDictionary
                let image = owner?["avatar_url"] as? String ?? ""
                getRepositories.append(Repository(fullName: fullName, language: language, stars: stars, wachers: wachers, forks: forks, issues: issues, image: image))
            }
        }
        return getRepositories
    }
    
    func cancelSearch() {
        task?.cancel()
    }
    
}

enum RepositoryError: Error {
    case noDataAvailable
    case cannotProccesData
}
