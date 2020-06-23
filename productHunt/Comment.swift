//
//  Comment.swift
//  productHunt
//
//  Created by Anika Morris on 6/23/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let body: String
}

struct CommentApiResponse: Decodable {
    let comments: [Comment]
}
