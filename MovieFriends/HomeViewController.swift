//
//  HomeViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 4/25/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var image1: UIImageView!
    
    let baseURL = "https://api.themoviedb.org/3/trending/movie/week?api_key="
    let apiKey = "0518529e7e2dd0cf9c39e55884e0a084"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSON()
    }
    
    func getJSON() {
        var url = self.baseURL
        url = url + apiKey
        
        let request = URL(string: url)!
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            
            if error != nil {
                
                print("There was an error!")
            } else {
                do {
                   
                    let swiftyJSON = try JSON(data: data!)
                    let theTitle = swiftyJSON["results"].arrayValue
                    let theImage = swiftyJSON["results"][0]["poster_path"].string!
                    
                    let theImageURL = URL(string: theImage)
                    print("WAter is good")
                    if let ImageData = NSData(contentsOf: theImageURL! as URL) {
                        self.image1.image = UIImage(data: ImageData as Data)
                        
                        print("The image loaded")
                    }

                    
                    for title in theTitle {
                        let titles = title["title"].stringValue
                        //print(titles)
                    }

                    let theTest = "Chicken nugget"
                    let theTest2 = "Water cup"
                    //print(theTest2)
                    print(theImage)
                    //print(theTest)
                    
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        
        task.resume()
    }

}
