//
//  MyProfileViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/12/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var profPic: UIImageView!
    
    var nameText: String = "Hello"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = nameText
        print(name.text)
    }
    

}
