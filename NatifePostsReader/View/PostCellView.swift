//
//  PostCellView.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import UIKit

class PostCellView: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewTextLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    var onButtonClicked: (()->(Void))!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        onButtonClicked()
    }
    
    func setupData(postData: Post, isExpanded: Bool = false) {
        let hideButton = postData.previewText.fitsNumberOfLines(Constants.requiredTextLinesForExpand, font: previewTextLabel.font, width: previewTextLabel.bounds.width)
        titleLabel.text = postData.title
        
        previewTextLabel.text = postData.previewText
        previewTextLabel.numberOfLines = isExpanded ? 0 : 2
        
        likesCountLabel.text = "\(postData.likesCount)"
        dateLabel.text = "\(postData.postedDateText)"
        
        expandButton.isHidden = hideButton
        expandButton.titleLabel?.text = isExpanded ? Constants.collapseText : Constants.expandText
    }
}
