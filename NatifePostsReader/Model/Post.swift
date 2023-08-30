//
//  Post.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import Foundation

struct Post: Codable {
    let postId: Int
    let timeshamp: TimeInterval
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
    
    var postedDateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y, HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: timeshamp))
    }
}
