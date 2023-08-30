//
//  PostInfo.swift
//  NatifePostsReader
//
//  Created by Tobias on 30.08.2023.
//

import Foundation

struct PostInfo: Codable {
    let post: PostDetails
    
    private enum CodingKeys: String, CodingKey {
        case post
    }
}
