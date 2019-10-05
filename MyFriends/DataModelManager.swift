//
//  DataModelManager.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import Foundation
import UIKit

class DataModalManager {
    
    // MARK: Data properties
    var friendPackage = FriendPackage()
    
    // MARK: - Initializers
    init() {
        
        loadData()
        
        // First time loading?
        if friendPackage.data.count == 0 {
            friendPackage.data.append(Friend(firstName: "Max", lastName: "Rabiner", age: 20, city: "Richmond Hill", imageName: ""))
            friendPackage.data.append(Friend(firstName: "Tom", lastName: "Jerry", age: 23, city: "Toronto", imageName: ""))
            friendPackage.data.append(Friend(firstName: "Nacho", lastName: "Mickey", age: 25, city: "Markham", imageName: ""))
            
            friendPackage.count = friendPackage.data.count
        }
    }
    
    func FriendsGet() -> FriendPackage {
        return friendPackage
    }
    
    private func appBundlePath() -> String? {
        return Bundle.main.path(forResource: "data-friends", ofType: "json")
    }
    
    private func appDocumentsPath() -> URL? {
        return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("data-friends.json")
    }
    
    private func loadData() {
        
        var appData = Data()
        
        if let path = appDocumentsPath() {
            do {
                appData = try Data(contentsOf: path)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        else if let path = appBundlePath() {
            do {
                appData = try Data(contentsOf: URL(fileURLWithPath: path))
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        // Attempt to decode, but only if appData has something in it
        if appData.count > 0 {
            // Create and configure a JSON decoder
            let decoder = JSONDecoder()
            // Choose the desired date decoding strategy
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            // Attempt to decode the data into a "FriendPackage" object
            do {
                let result = try decoder.decode(FriendPackage.self, from: appData)
                // Publish the result
                self.friendPackage = result
            }
            catch {
                print("Decode error", error)
            }
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        if let encodedData = try? encoder.encode(self.friendPackage) {
            do {
                try encodedData.write(to: appDocumentsPath()!)
            }
            catch {
                print("Failed to write friends data: \(error.localizedDescription)")
            }
        }
    }
    
    func friendAdd(_ newItem: Friend) -> Friend? {
        let localNewItem = newItem
        if !newItem.firstName.isEmpty && !newItem.lastName.isEmpty && newItem.age > 0 && !newItem.city.isEmpty {
            friendPackage.data.append(localNewItem)
            friendPackage.count = friendPackage.data.count
            friendPackage.timestamp = Date()
            
            return friendPackage.data.last
        }
        return nil
    }
    
    func friendsSortedByFirstName() -> [Friend] {
        let sortedFriends = friendPackage.data.sorted(by: { (f1: Friend, f2: Friend) -> Bool in return f1.firstName.lowercased() < f2.firstName.lowercased() })
        
        return sortedFriends
    }
    
    func loadImage(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    
    func saveImage(imageName: String, image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = imageName
        let fileUrl = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        do {
            try data.write(to: fileUrl)
        }
        catch let error {
            print("Error saving: \(error)")
        }
    }
    
   
    
}
