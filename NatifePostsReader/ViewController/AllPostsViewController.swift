//
//  AllPostsViewController.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import UIKit
import Combine

class AllPostsViewController: UIViewController {

    @IBOutlet weak var text: UILabel!
    let postsViewModel = PostsViewModel()
    
    private var cancelable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
    }
    
    func binding(){
        postsViewModel.$errorText
            .sink { [weak self] currentError in
                self?.text.text = currentError
            }
            .store(in: &cancelable)
    }
}

