//
//  Post.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation

struct Post : Codable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int

    private enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
