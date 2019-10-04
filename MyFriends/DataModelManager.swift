//
//  DataModelManager.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import Foundation

class DataModalManager {
    
    var urlDocumentsFriends: URL?
    var pathBundleFriends: String?
    var friends: FriendPackage!
    
    init() {
        
        urlDocumentsFriends = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("data-friends.json")
        
        pathBundleFriends = Bundle.main.path(forResource: "data-friends", ofType: "json")
        
        loadData()
    }
    
    func FriendsGet() -> FriendPackage {
        return friends
    }
    
    private func loadData() {
        
        var friendsData: Data!
        
        if FileManager.default.fileExists(atPath: urlDocumentsFriends!.absoluteString) {
            do {
                friendsData = try Data(contentsOf: urlDocumentsFriends!)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        else {
            do {
                friendsData = try Data(contentsOf: URL(fileURLWithPath: pathBundleFriends!))
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        do {
            let result = try decoder.decode(FriendPackage.self, from: friendsData)
            self.friends = result
        }
        catch {
            print(error)
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        if let encodedData = try? encoder.encode(self.friends) {
            do {
                try encodedData.write(to: urlDocumentsFriends!)
            }
            catch {
                print("Failed to write friends data: \(error.localizedDescription)")
            }
        }
    }
    
    func friendAdd(_ newItem: Friend) -> Friend? {
        let localNewItem = newItem
        if !newItem.firstName.isEmpty && !newItem.lastName.isEmpty && newItem.age > 0 && !newItem.city.isEmpty {
            friends.data.append(localNewItem)
            friends.count = friends.data.count
            friends.timestamp = Date()
            
            return friends.data.last
        }
        return nil
    }
    
}
