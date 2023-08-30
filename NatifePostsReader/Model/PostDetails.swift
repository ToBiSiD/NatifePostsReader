//
//  PostDetails.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation

struct PostDetails: Codable {
    let postId: Int
    let timeshamp: TimeInterval
    let title: String
    let text: String
    let postImage: String
    let likesCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case text
        case postImage
        case likesCount = "likes_count"
    }
    
    var postedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y, HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: timeshamp))
    }
}

