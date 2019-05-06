//
//  HomeViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 4/25/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
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
                    let theImage1 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][0]["poster_path"].string!
                    let theImage2 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][1]["poster_path"].string!
                    let theImage3 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][2]["poster_path"].string!
                    let theImage4 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][3]["poster_path"].string!
                    print(theImage1)
                    let theImageURL1 = URL(string: theImage1)
                    let theImageURL2 = URL(string: theImage2)
                    let theImageURL3 = URL(string: theImage3)
                    let theImageURL4 = URL(string: theImage4)
                    print("WAter is good")
                    DispatchQueue.main.async{
                        if let ImageData1 = NSData(contentsOf: theImageURL1!) {
                            self.button1.setImage(UIImage(data: ImageData1 as Data), for: .normal)
                            print("The image loaded")
                        }
                        if let ImageData2 = NSData(contentsOf: theImageURL2!) {
                            self.button2.setImage(UIImage(data: ImageData2 as Data), for: .normal)
                            print("The image loaded")
                        }
                        if let ImageData3 = NSData(contentsOf: theImageURL3!) {
                            self.button3.setImage(UIImage(data: ImageData3 as Data), for: .normal)
                            print("The image loaded")
                        }
                        if let ImageData4 = NSData(contentsOf: theImageURL4!) {
                            self.button4.setImage(UIImage(data: ImageData4 as Data), for: .normal)
                            print("The image loaded")
                        }
                    }
                    
                    for title in theTitle {
                        let titles = title["title"].stringValue
                        //print(titles)
                    }

                    let theTest = "Chicken nugget"
                    let theTest2 = "Water cup"
                    //print(theTest2)
                    //print(theTest)
                    
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        
        task.resume()
    }

}
