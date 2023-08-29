//
//  PostReaderAPI.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation

class PostReaderAPI {
    private let postsLink = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    private let postDetailsLink = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/"
    
    func fetchPosts(completion: @escaping (Result<AllPosts, Error>) -> Void) {
        guard let url = URL(string: postsLink) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        fetchData(with: url, completion: completion)
    }
    
    func fetchPostDetails(postId: String, completion: @escaping (Result<PostDetails, Error>) -> Void) {
        let fullLink = postDetailsLink + postId + ".json"
        guard let url = URL(string: fullLink) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        fetchData(with: url, completion: completion)
    }
    
    private func fetchData<T: Codable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodeData = try decoder.decode(T.self, from: data)
                    completion(.success(decodeData))
                } catch {
                    completion(.failure(error))
                }
            }
            else {
                completion(.failure(NSError(domain: "No data of type \(T.self) received", code: 0, userInfo: nil)))
            }
        }
        .resume()
    }
}
