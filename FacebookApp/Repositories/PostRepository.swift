//
//  PostRepository.swift
//  FacebookApp
//
//  Created by joehsieh on 2022/01/03.
//  Copyright © 2022 NJ. All rights reserved.
//

import Foundation

protocol PostRepositoryInterface {
    func getPosts() -> [Post]
}

final class PostRepository: PostRepositoryInterface {
    // TODO: [Joe] Pagination
    func getPosts() -> [Post] {
        var posts = [Post]()
        for _ in 0 ..< 100 {
            posts.append(Post())
        }
        return posts
    }
}
