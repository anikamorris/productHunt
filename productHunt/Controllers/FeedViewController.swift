//
//  FeedViewController.swift
//  productHunt
//
//  Created by Anika Morris on 6/21/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var posts: [Post] = [] {
       didSet {
           feedTableView.reloadData()
       }
    }
    
    var networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        feedTableView.delegate = self
        feedTableView.dataSource = self
        updateFeed()
    }
    
    func updateFeed() {
      // call our network manager's getPosts method to update our feed with posts
       networkManager.getPosts() { result in
           switch result {
           case let .success(posts):
             self.posts = posts
           case let .failure(error):
             print(error)
           }
       }
    }
}

extension FeedViewController: UITableViewDataSource {
   // Determines how many cells will be shown on the table view.
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return posts.count
   }

   // Creates and configures each cell.
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // dequeue and return an available cell, instead of creating a new cell
      let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell

      // Grab a post from our "data"
      let post = posts[indexPath.row]
      // Assign a post to that cell
      cell.post = post
      return cell
   }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        // Get the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Get the commentsView from the storyboard
        guard let commentsView = storyboard.instantiateViewController(withIdentifier: "commentsView") as? CommentsViewController else {
            return
        }
        commentsView.postID = post.id
        navigationController?.pushViewController(commentsView, animated: true)

    }
}
