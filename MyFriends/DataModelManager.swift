//
//  DataModelManager.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import Foundation

class DataModalManager {
    
    private var friend1: Friend
    private var friend2: Friend
    private var friend3: Friend
    private var friend4: Friend
    private var friends: PackageFriends
    
    init() {
        friend1 = Friend(firstName: "Max", lastName: "Rabs", age: 20, city: "Toronto")
        friend2 = Friend(firstName: "Nacho", lastName: "Libre", age: 18, city: "Rhill")
        friend3 = Friend(firstName: "Mickey", lastName: "Jerry", age: 23, city: "Markham")
        friend4 = Friend(firstName: "Tom", lastName: "Jeff", age: 24, city: "Toronto")
        
        friends = PackageFriends(firstName: "Eric", lastName: "Rabiner", timestamp: Date(), count: 4, data: [friend1, friend2, friend3, friend4])
    }
    
    func FriendsGet() -> PackageFriends {
        return friends
    }

}
