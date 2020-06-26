//
//  PostTableViewCell.swift
//  productHunt
//
//  Created by Anika Morris on 6/21/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
 
    var post: Post? {
        didSet {
            // make sure we return if post doesn't exist
            guard let post = post else { return }
            // Assign our UI elements to their post counterparts
            nameLabel.text = post.name
            taglineLabel.text = post.tagline
            commentsCountLabel.text = "Comments: \(post.commentsCount)"
            votesCountLabel.text = "Votes: \(post.votesCount)"
            updatePreviewImage()
        }
    }
    
    func updatePreviewImage() {
        // make sure we return if post doesn't exist
        guard let post = post else { return }
        // assign the placeholder image to the UI element
        downloadImage(from: post.previewImageURL)
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.productImageView.image = UIImage(data: data)
            }
        }
    }
}
