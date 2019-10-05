//
//  FriendScene.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import UIKit

class FriendScene: UIViewController {
    
    // MARK: - Instance variables
    var item: Friend!
    var m: DataModalManager!
    
    // MARK: - Outlets
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        firstName.text = item.firstName
        lastName.text = item.lastName
        age.text = String(item.age)
        city.text = item.city
        
        if item.imageName == "" {
            photo.image = UIImage(named: "blankphoto")
        }
        else {
            let image = m.loadImage(fileName: item.imageName)
            photo.image = image
            
        }
    }
    
    
   
}
