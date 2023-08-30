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
    private var sortedPosts: [Post] = []
    private var expandedCells: IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.postCellViewName, bundle: nil), forCellReuseIdentifier: Constants.postCellIdentifier)
        
        loadPosts()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        expandedCells.removeAll()
        tableView.reloadData()
    }
    
    private func loadPosts() {
        postReaderAPI.fetchPosts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let allPosts):
                    self.setupData(allPosts: allPosts.posts)
                case .failure(let error):
                    self.showErrorText(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupData(allPosts: [Post]) {
        posts = allPosts
        sortedPosts = posts
        errorText.isHidden = true
        
        addSortButton()
        
        tableView.reloadData()
    }
    
    private func showErrorText(_ error: String) {
        errorText.text = error
        errorText.isHidden = false
    }
    
    func addSortButton() {
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(showSortingOptions))
        
        navigationItem.rightBarButtonItem = sortButton
    }
    
    
    @objc func showSortingOptions() {
        let alertController = UIAlertController(title: "Sort Options", message: "Choose a sorting option", preferredStyle: .actionSheet)
        
        let defaultSort = UIAlertAction(title: "Default sort", style: .default) { _ in
            self.sortPosts(sortingOption: .none)
        }
        
        let dateSortAscending = UIAlertAction(title: "Sort by Date (Ascending)", style: .default) { _ in
            self.sortPosts(sortingOption: .byDate(ascending: true))
        }
        
        let dateSortDescending = UIAlertAction(title: "Sort by Date (Descending)", style: .default) { _ in
            self.sortPosts(sortingOption: .byDate(ascending: false))
        }
        
        let ratingSortAscending = UIAlertAction(title: "Sort by Rating (Ascending)", style: .default) { _ in
            self.sortPosts(sortingOption: .byRating(ascending: true))
        }
        
        let ratingSortDescending = UIAlertAction(title: "Sort by Rating (Descending)", style: .default) { _ in
            self.sortPosts(sortingOption: .byRating(ascending: false))
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(defaultSort)
        alertController.addAction(dateSortAscending)
        alertController.addAction(dateSortDescending)
        alertController.addAction(ratingSortAscending)
        alertController.addAction(ratingSortDescending)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func sortPosts(sortingOption: SortOption = .none) {
        switch sortingOption {
        case .none:
            sortedPosts = posts
        case .byDate(let ascending):
            sortedPosts.sort { ascending ? $0.timeshamp < $1.timeshamp : $0.timeshamp > $1.timeshamp }
        case .byRating(let ascending):
            sortedPosts.sort { ascending ? $0.likesCount > $1.likesCount : $0.likesCount < $1.likesCount }
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PostDetailsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.postId = sortedPosts[indexPath.row].postId
        }
    }
}

extension AllPostsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.postCellIdentifier, for: indexPath) as? PostCellView else { return UITableViewCell() }
        cell.setupData(postData: sortedPosts[indexPath.row], isExpanded: expandedCells.contains(indexPath.row))
        
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

