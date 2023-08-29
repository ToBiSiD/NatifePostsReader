//
//  PostsViewModel.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation
import Combine

class PostsViewModel {
    @Published var posts: AllPosts?
    @Published var errorText: String?
    
    private let postReaderAPI = PostReaderAPI()
    private var cancelableSet: Set<AnyCancellable> = []
    
    init() {
        postReaderAPI.fetchPosts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.errorText = nil
                case .failure(let error):
                    self.errorText = error.localizedDescription
                }
            }
        }
    }
}
