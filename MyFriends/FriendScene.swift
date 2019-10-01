//
//  FriendScene.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import UIKit

class FriendScene: UIViewController {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var indexPath: IndexPath!
    var friendPackage: PackageFriends!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstName.text = friendPackage.data[indexPath.row].firstName
        lastName.text = friendPackage.data[indexPath.row].lastName
        age.text = String(friendPackage.data[indexPath.row].age)
        city.text = friendPackage.data[indexPath.row].city
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
