//
//  PostReaderAPI.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation

class PostReaderAPI {
    func fetchPosts(completion: @escaping (Result<PostsContainer, Error>) -> Void) {
        fetchData(with: Constants.postsLink, completion: completion)
    }
    
    func fetchPostDetails(postId: Int, completion: @escaping (Result<PostInfo, Error>) -> Void) {
        let fullLink = "\(Constants.postDetailsLink)\(postId).json"
        fetchData(with: fullLink, completion: completion)
    }
    
    private func fetchData<T: Codable>(with urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
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
                    print(String(describing: error))
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
