//
//  DataModelClasses.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import Foundation

class Friend: Codable {
    // MARK: - Data properties
    var firstName: String = ""
    var lastName: String = ""
    var age: Int = 0
    var city: String = ""
    var imageName: String = ""
    
    // MARK: - Initializers
    init(firstName: String, lastName: String, age: Int, city: String, imageName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.city = city
        self.imageName = imageName
    }
}

class FriendPackage: Codable {
    // MARK: - Data properties
    var timestamp: Date = Date()
    var version: String = "1.0.0"
    var count: Int = 0
    var data = [Friend]()
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
