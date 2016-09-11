//
//  Post.swift
//  FacebookApp
//
//  Created by joehsieh on 2016/8/20.
//  Copyright © 2016年 NJ. All rights reserved.
//

import UIKit
// TODO: Cannot build Fakery succueesfully, so jus ignore it as a workaround.
//import Fakery

class Post {
    
//    let faker = Faker(locale: "en")
    convenience init(title:String, comment:String) {
        self.init()
    }
    init() {
//        name = faker.name.firstName()
//        statusText = faker.lorem.paragraphs(amount: Int(arc4random_uniform(10)) + 1)
//        profileImageName = name
//        statusImageName = name
        name = "Joe"
        statusText = "testStatusText"
        profileImageName = name
        statusImageName = name
    }
    var statusText = "testStatusText"
    var profileImageName = ""
    var name = "testName"
    var statusImageName = ""
    let identifier = NSUUID().uuidString
}
