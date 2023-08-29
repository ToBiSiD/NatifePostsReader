//
//  PostDetails.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation

struct PostDetails : Codable {
    let postId: String
    let timeshamp: Int
    let title: String
    let text: String
    let postImage: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId, timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}
