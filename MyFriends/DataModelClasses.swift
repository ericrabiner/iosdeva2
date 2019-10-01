//
//  DataModelClasses.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import Foundation

struct Friend: Codable {
    let firstName: String
    let lastName: String
    let age: Int
    let city: String
}

struct PackageFriends: Codable {
    let firstName: String
    let lastName: String
    let timestamp: Date
    let count: Int
    var data: [Friend]
}
