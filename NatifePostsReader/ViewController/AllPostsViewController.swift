//
//  AllPostsViewController.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import UIKit
import Combine

class AllPostsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var text: UILabel!
    
    let postsViewModel = PostsViewModel()
    private var posts: [Post] = []
    private var expandedCells: IndexSet = []
    private var cancelable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.postCellViewName, bundle: nil), forCellReuseIdentifier: Constants.postCellIdentifier)
        
        binding()
    }
    
    func binding(){
        postsViewModel.$errorText
            .sink { [weak self] currentError in
                print(currentError)
               // self?.text.text = currentError
            }
            .store(in: &cancelable)
        
        postsViewModel.$posts
            .sink { [weak self] allPosts in
                if let allPosts = allPosts {
                    self?.posts = allPosts.posts
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancelable)
    }
}

extension AllPostsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.postCellIdentifier, for: indexPath) as? PostCellView else { return UITableViewCell() }
        cell.setupData(postData: posts[indexPath.row], isExpanded: expandedCells.contains(indexPath.row))
        
        cell.onButtonClicked = {
            if self.expandedCells.contains(indexPath.row) {
                self.expandedCells.remove(indexPath.row)
            } else {
                self.expandedCells.insert(indexPath.row)
            }
            
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

