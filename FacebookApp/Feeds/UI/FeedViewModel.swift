//
//  FeedViewModel.swift
//  FacebookApp
//
//  Created by joehsieh on 2022/01/03.
//  Copyright © 2022 NJ. All rights reserved.
//

import Foundation
import UIKit

final class FeedViewModel {
    let postRepository: PostRepositoryInterface

    init(postRepository: PostRepositoryInterface) {
        self.postRepository = postRepository
    }
    
    lazy var posts: [Post] = {
        return postRepository.getPosts()
    }()
}
