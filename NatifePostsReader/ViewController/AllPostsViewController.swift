//
//  AllPostsViewController.swift
//  NatifePostsReader
//
//  Created by Tobias on 29.08.2023.
//

import UIKit

class AllPostsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorText: UILabel!

    private let postReaderAPI = PostReaderAPI()
    private var posts: [Post] = []
    private var expandedCells: IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.postCellViewName, bundle: nil), forCellReuseIdentifier: Constants.postCellIdentifier)
        
        loadPosts()
    }
    
    func loadPosts() {
        postReaderAPI.fetchPosts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let allpPosts):
                    self.posts = allpPosts.posts
                    self.errorText.isHidden = true
                    self.tableView.reloadData()
                case .failure(let error):
                    self.errorText.text = error.localizedDescription
                    self.errorText.isHidden = false
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PostDetailsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.postId = posts[indexPath.row].postId
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.showPostDetails, sender: self)
    }
}

