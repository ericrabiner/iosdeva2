//
//  FriendList.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendFirstName: UILabel!
    @IBOutlet weak var friendLastName: UILabel!
}

class FriendList: UITableViewController, FriendAddDelegate {
    
    // MARK: - Instance variables
    var m: DataModalManager!
    var items = [Friend]()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = m.friendsSortedByFirstName()
        title = "Eric's friends"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = m.friendsSortedByFirstName()
        tableView.reloadData()
    }
    
    func showDetailDone(_ controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addTaskDidCancel(_ controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addTask(_ controller: UIViewController, didSave item: Friend) {
        if m.friendAdd(item) != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath) as! FriendsTableViewCell

        // Configure the cell...
        cell.friendFirstName?.text = items[indexPath.row].firstName
        cell.friendLastName?.text = items[indexPath.row].lastName
        
        if items[indexPath.row].imageName == "" {
            cell.friendImage!.image = UIImage(named: "blankphoto")
        }
        else {
            cell.friendImage!.image = m.loadImage(fileName: items[indexPath.row].imageName)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // iOS runtime calls this when user taps on row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendDetail" {
            let vc = segue.destination as! FriendScene
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let selectedData = items[indexPath!.row]
            vc.item = selectedData
            vc.m = m
            vc.title = "Friend Details"
        }
        
        if segue.identifier == "toFriendAdd" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers[0] as! FriendAdd
            vc.title = "Add Friend"
            vc.m = m
            vc.delegate = self
        }
    }
    
}
