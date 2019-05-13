//
//  EditProfileViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/12/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit
import CoreData

class EditProfileViewController: UIViewController {

    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profImage: UIImageView!
    
    var person = [NSManagedObject]()
    var managedObjectContext: NSManagedObjectContext?
    var chosenImage: UIImage?
    
    var imagePicker = UIImagePickerController()
    var nameText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!
        
        let person = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        chosenImage = profImage.image
        let imageData = chosenImage!.pngData();
        
        person.setValue(nameTextField.text, forKeyPath: "name")
        person.setValue(descTextView.text, forKeyPath: "bio")
        person.setValue(imageData, forKey: "profilepic")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
        
        dismiss(animated: true, completion: nil)

    }
    
    
    
    @IBAction func changeImageButton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    

}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profImage.image = image
    }
        
        dismiss(animated: true, completion: nil)
    }
}
