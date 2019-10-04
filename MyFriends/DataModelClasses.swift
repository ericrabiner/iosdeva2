//
//  DataModelClasses.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import Foundation

class Friend: Codable {
    var firstName: String
    var lastName: String
    var age: Int
    var city: String
    
    init(firstName: String, lastName: String, age: Int, city: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.city = city
    }
}

class FriendPackage: Codable {
    var timestamp: Date
    var version: String
    var count: Int
    var data: [Friend]
    
    init(timestamp: Date, version: String, count: Int, data: [Friend]) {
        self.timestamp = timestamp
        self.version = version
        self.count = count
        self.data = data
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
