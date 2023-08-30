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
        let postData = Date(timeIntervalSince1970: timeshamp)
        let difference = postData.datesDifference(Date())
        
        if let postedDays = difference.day, postedDays < 30{
            switch postedDays {
            case 1: return "posted yesturday"
            case 2: return "posted day before yesterday"
            default : return "posted \(postedDays)s days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm, d MMM y"
            return "posted at \(postData.formatted())"
        }
    }
}
