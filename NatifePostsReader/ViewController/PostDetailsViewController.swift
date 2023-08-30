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
    private let postReaderAPI = PostReaderAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let postId = postId {
            postReaderAPI.fetchPostDetails(postId: postId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let postInfo):
                        self.setupPostDetails(postData: postInfo.post)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
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
