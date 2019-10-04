//
//  FriendList.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-01.
//  Copyright © 2019 sict. All rights reserved.
//

import UIKit

class FriendList: UITableViewController, FriendAddDelegate {
    
    // MARK: - Instance variables
    var m: DataModalManager!
    
    private var friendPackage: FriendPackage!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendPackage = m.FriendsGet()
        title = "Eric's friends"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        friendPackage = m.FriendsGet()
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
        return friendPackage.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = friendPackage.data[indexPath.row].firstName
        cell.detailTextLabel?.text =  friendPackage.data[indexPath.row].lastName
        
        return cell
    }
    
    // iOS runtime calls this when user taps on row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendDetail" {
            let vc = segue.destination as! FriendScene
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            vc.friendPackage = friendPackage
            vc.indexPath = indexPath
            vc.title = "Friend Details"
        }
        
        if segue.identifier == "toFriendAdd" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers[0] as! FriendAdd
            vc.title = "Add Friend"
            vc.delegate = self
        }
    }
    
}
