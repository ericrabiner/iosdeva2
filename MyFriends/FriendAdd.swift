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

class FriendAdd: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Instance variables
    weak var delegate: FriendAddDelegate?
    var photo: UIImage?
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var pickedPhoto: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstNameInput.becomeFirstResponder()
    }
    
    func getPhotoWithCameraOrPhotoLibrary() {
        
        // Create the image picker controller
        let c = UIImagePickerController()
        
        // Determine what we can use...
        // Prefer the camera, but can use the photo library
        c.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        
        c.delegate = self
        c.allowsEditing = false
        // Show the controller
        present(c, animated: true, completion: nil)
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
    
    @IBAction func addPhoto(_ sender: UIButton) {
        getPhotoWithCameraOrPhotoLibrary()
    }
    
    // MARK: - Image picker delegate methods
    // Cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // Save
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        pickedPhoto.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

}
