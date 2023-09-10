//
//  PostReaderAPI.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation

class PostReaderAPI {
    static let shared = PostReaderAPI()
    
    func fetchPosts() async throws -> PostsContainer {
        return try await fetchData(from: Constants.postsLink)
    }
    
    func fetchPostDetails(for postId: Int) async throws -> PostInfo{
        let fullLink = "\(Constants.postDetailsLink)\(postId).json"
        return try await fetchData(from: fullLink)
    }
    
    private func fetchData<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw PostReaderAPIError.invalidUrl }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodeData = try JSONDecoder().decode(T.self, from: data)
        return decodeData
    }
}
