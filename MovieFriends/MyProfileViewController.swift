//
//  MyProfileViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/12/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit
import CoreData

class MyProfileViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var profPic: UIImageView!
    
    var person: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Profile")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                name.text = data.value(forKey: "name") as? String
                bio.text = data.value(forKey: "bio") as? String
                profPic.image = UIImage(data: data.value(forKey: "profilepic") as! Data)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}
