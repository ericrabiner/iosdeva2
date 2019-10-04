//
//  FriendAdd.swift
//  MyFriends
//
//  Created by Eric Rabiner on 2019-10-04.
//  Copyright © 2019 sict. All rights reserved.
//

import UIKit

protocol FriendAddDelegate: AnyObject {
    
    func addTaskDidCancel(_ controller: UIViewController)
    
    func addTask(_ controller: UIViewController, didSave item: Friend)
    // In general, the item type is suggested as Any, which you can cast, or...
    // Recommendation - change the type to match the actual item type
}

class FriendAdd: UIViewController {
    
    // MARK: - Instance variables
    weak var delegate: FriendAddDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstNameInput.becomeFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        view.endEditing(false)
        errorMessage.text?.removeAll()
        
        // Validation before saving
        
        if firstNameInput.text!.isEmpty {
            errorMessage.text = "Invalid first name."
            return
        }
        
        if lastNameInput.text!.isEmpty {
            errorMessage.text = "Invalid last name."
            return
        }
        
        if cityInput.text!.isEmpty {
            errorMessage.text = "Invalid city."
            return
        }
        
        if ageInput.text!.isEmpty {
            errorMessage.text = "Invalid age."
            return
        }
        
        var age: Int = 0
        // Attempt to get the numeric value
        if let value = Int(ageInput.text!) {
            // Yes, successful, save it for later
            age = value
            // Mxust be a number that makes sense
            if value <= 0 {
                errorMessage.text = "Invalid age"
                return
            }
        }
        
        // Validation Passes here
        
        // Create a friend Object
        let newFriend = Friend(firstName: firstNameInput.text!, lastName: lastNameInput.text!, age: age, city: cityInput.text!)
        
        errorMessage.text = "Attempting to save..."
        
        delegate?.addTask(self, didSave: newFriend)
        
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.addTaskDidCancel(self)
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
