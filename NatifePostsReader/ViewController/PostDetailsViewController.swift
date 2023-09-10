//
//  PostDetailsViewController.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import UIKit

class PostDetailsViewController: UIViewController {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesAmountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var postId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let postId = postId {
            Task {
                do {
                    let postInfo = try await PostReaderAPI.shared.fetchPostDetails(for: postId)
                    self.setupPostDetails(postData: postInfo.post)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupPostDetails(postData: PostDetails) {
        self.postImage.imageFromUrl(urlString: postData.postImage)
        self.titleLabel.text = postData.title
        self.postTextLabel.text = postData.text
        self.likesAmountLabel.text = "\(postData.likesCount)"
        self.dateLabel.text =  postData.postedDate
    }
}
