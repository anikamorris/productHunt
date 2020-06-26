//
//  Post.swift
//  productHunt
//
//  Created by Anika Morris on 6/21/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct Post {
    let id: Int
    let name: String
    let tagline: String
    let votesCount: Int
    let commentsCount: Int
    let previewImageURL: URL
}

// Have a matching decodable array in our struct for the array of posts we get back from the API
struct PostList: Decodable {
   var posts: [Post]
}

extension Post: Decodable {
    enum PostKeys: String, CodingKey {
        // first three match our variable names for our Post struct
        case id = "id"
        case name = "name"
        case tagline = "tagline"
        // these three need to be mapped since they're named differently on the API compared to our struct
        case votesCount = "votes_count"
        case commentsCount = "comments_count"
        case previewImageURL = "screenshot_url"
    }
    
    enum PreviewImageURLKeys: String, CodingKey {
       // for all posts, we only want the 850px image
       case imageURL = "850px"
    }
    
    init(from decoder: Decoder) throws {
        // Decode the Post from the API call
        let postsContainer = try decoder.container(keyedBy: PostKeys.self)
        // Decode each of the properties from the API into the appropriate type (string, etc.) for their associated struct variable
        id = try postsContainer.decode(Int.self, forKey: .id)
        name = try postsContainer.decode(String.self, forKey: .name)
        tagline = try postsContainer.decode(String.self, forKey: .tagline)
        votesCount = try postsContainer.decode(Int.self, forKey: .votesCount)
        commentsCount = try postsContainer.decode(Int.self, forKey: .commentsCount)
        // Get the container (screenshot_url/previewImageURL) nested within our postsContainer.
        let screenshotURLContainer = try postsContainer.nestedContainer(keyedBy: PreviewImageURLKeys.self, forKey: .previewImageURL)
        // Decode the image and assign it to the variable
        previewImageURL = try screenshotURLContainer.decode(URL.self, forKey: .imageURL)
    }
}
