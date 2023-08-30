//
//  StructExtensions.swift
//  NatifePostsReader
//
//  Created by Tobias on 30.08.2023.
//

import Foundation
import UIKit

extension String {
    func fitsNumberOfLines(_ numberOfLines: Int, font: UIFont, width: CGFloat) -> Bool {
        let lineHeight = font.lineHeight
        let targetHeight = CGFloat(numberOfLines) * lineHeight
        
        let textRect = (self as NSString).boundingRect(
            with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        
        return textRect.height <= targetHeight
    }
}

extension Date {
    func datesDifference(_ second: Date) -> DateComponents {
        let startDate = self as Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: startDate, to: second)
        return components
    }
}
