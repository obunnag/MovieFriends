//
//  EditProfileViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/12/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profImage: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        let vc = MyProfileViewController(nibName: "MyProfileViewController", bundle: nil)
        vc.nameText = nameTextField.text!
        print(vc.nameText)
        //vc.text = descTextView.text!

        navigationController?.pushViewController(vc, animated: true)
        
        
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
