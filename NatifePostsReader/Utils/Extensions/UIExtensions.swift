//
//  UIExtensions.swift
//  NatifePostsReader
//
//  Created by Tobias on 30.08.2023.
//

import Foundation
import UIKit

extension UILabel {
    func fitsNumberOfLines(_ numberOfLines: Int) -> Bool {
        guard let text = self.text, let font = self.font else {
            return false
        }
        
        let lineHeight = font.lineHeight
        let targetHeight = CGFloat(numberOfLines) * lineHeight
        
        let textRect = self.textRect(forBounds: self.bounds, limitedToNumberOfLines: numberOfLines)
        return textRect.height <= targetHeight
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
}
