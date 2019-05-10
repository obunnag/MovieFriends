//
//  HomeViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 4/25/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var movieIDInput: String = ""
    var id1: String = ""
    var id2: String = ""
    var id3: String = ""
    var id4: String = ""
    var id5: String = ""
    var id6: String = ""
    var id7: String = ""
    var id8: String = ""
    var id9: String = ""
    var id10: String = ""
    var id11: String = ""
    var id12: String = ""
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    
    @IBAction func movieDesc(sender: AnyObject){
    guard let button = sender as? UIButton else{
    return
    }
    
    switch button.tag{
    case 1:
        movieIDInput = id1
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 2:
        movieIDInput = id2
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 3:
        movieIDInput = id3
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 4:
        movieIDInput = id4
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 5:
        movieIDInput = id5
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 6:
        movieIDInput = id6
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 7:
        movieIDInput = id7
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 8:
        movieIDInput = id8
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 9:
        movieIDInput = id9
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 10:
        movieIDInput = id10
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 11:
        movieIDInput = id11
        performSegue(withIdentifier: "movieSegue", sender: self)
    case 12:
        movieIDInput = id12
        performSegue(withIdentifier: "movieSegue", sender: self)
    default:
        print("Movie not found")
        return
    }
    }
    
    let baseURLPop = "https://api.themoviedb.org/3/trending/movie/week?api_key="
    let baseURLPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    let baseURLUpcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key="
    let apiKey = "0518529e7e2dd0cf9c39e55884e0a084"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSONPop()
        getJSONPlaying()
        getJSONUpcoming()
    }
    
    func getJSONPop() {
        var urlPop = self.baseURLPop
        urlPop = urlPop + apiKey
        
        let request = URL(string: urlPop)!
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            
            if error != nil {
                
                print("There was an error!")
            } else {
                do {
                   
                    let swiftyJSON = try JSON(data: data!)
                    
                    //Retrieve titles of movies
                    let theTitle = swiftyJSON["results"].arrayValue
                    
                    //Popular movie posters
                    let theImage1 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][0]["poster_path"].string!
                    let theImage2 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][1]["poster_path"].string!
                    let theImage3 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][2]["poster_path"].string!
                    let theImage4 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][3]["poster_path"].string!
                    let theImageURL1 = URL(string: theImage1)
                    let theImageURL2 = URL(string: theImage2)
                    let theImageURL3 = URL(string: theImage3)
                    let theImageURL4 = URL(string: theImage4)
                    
                    DispatchQueue.main.async{
                        if let ImageData1 = NSData(contentsOf: theImageURL1!) {
                            self.button1.setImage(UIImage(data: ImageData1 as Data), for: .normal)
                            self.id1 = String(swiftyJSON["results"][0]["id"].int!)
                        }
                        if let ImageData2 = NSData(contentsOf: theImageURL2!) {
                            self.button2.setImage(UIImage(data: ImageData2 as Data), for: .normal)
                            self.id2 = String(swiftyJSON["results"][1]["id"].int!)
                        }
                        if let ImageData3 = NSData(contentsOf: theImageURL3!) {
                            self.button3.setImage(UIImage(data: ImageData3 as Data), for: .normal)
                            self.id3 = String(swiftyJSON["results"][2]["id"].int!)
                        }
                        if let ImageData4 = NSData(contentsOf: theImageURL4!) {
                            self.button4.setImage(UIImage(data: ImageData4 as Data), for: .normal)
                            self.id4 = String(swiftyJSON["results"][3]["id"].int!)
                        }
                    }
                    
                    for title in theTitle {
                        let titles = title["title"].stringValue
                        //print(titles)
                    }

                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        
        task.resume()
    }
    
    func getJSONPlaying() {
        var urlPlaying = self.baseURLPlaying
        urlPlaying = urlPlaying + apiKey
        
        let request2 = URL(string: urlPlaying)!
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request2) { (data, response, error) -> Void in
            
            if error != nil {
                
                print("There was an error!")
            } else {
                do {
                    
                    let swiftyJSON = try JSON(data: data!)
                    
                    //Retrieve titles of movies
                    let theTitle = swiftyJSON["results"].arrayValue
                    
                    //New movie posters
                    let theImage5 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][0]["poster_path"].string!
                    let theImage6 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][1]["poster_path"].string!
                    let theImage7 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][2]["poster_path"].string!
                    let theImage8 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][3]["poster_path"].string!
                    let theImageURL5 = URL(string: theImage5)
                    let theImageURL6 = URL(string: theImage6)
                    let theImageURL7 = URL(string: theImage7)
                    let theImageURL8 = URL(string: theImage8)
                    
                    DispatchQueue.main.async{
                        if let ImageData5 = NSData(contentsOf: theImageURL5!) {
                            self.button5.setImage(UIImage(data: ImageData5 as Data), for: .normal)
                            self.id5 = String(swiftyJSON["results"][0]["id"].int!)
                        }
                        if let ImageData6 = NSData(contentsOf: theImageURL6!) {
                            self.button6.setImage(UIImage(data: ImageData6 as Data), for: .normal)
                            self.id6 = String(swiftyJSON["results"][1]["id"].int!)
                        }
                        if let ImageData7 = NSData(contentsOf: theImageURL7!) {
                            self.button7.setImage(UIImage(data: ImageData7 as Data), for: .normal)
                            self.id7 = String(swiftyJSON["results"][2]["id"].int!)
                        }
                        if let ImageData8 = NSData(contentsOf: theImageURL8!) {
                            self.button8.setImage(UIImage(data: ImageData8 as Data), for: .normal)
                            self.id8 = String(swiftyJSON["results"][3]["id"].int!)
                        }
                    }
                    
                    for title in theTitle {
                        let titles = title["title"].stringValue
                        //print(titles)
                    }
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        
        task2.resume()
    }
    
    func getJSONUpcoming() {
        var urlUpcoming = self.baseURLUpcoming
        urlUpcoming = urlUpcoming + apiKey
        
        let request3 = URL(string: urlUpcoming)!
        let session3 = URLSession.shared
        let task3 = session3.dataTask(with: request3) { (data, response, error) -> Void in
            
            if error != nil {
                
                print("There was an error!")
            } else {
                do {
                    
                    let swiftyJSON = try JSON(data: data!)
                    
                    //Retrieve titles of movies
                    let theTitle = swiftyJSON["results"].arrayValue
                    
                    //New movie posters
                    let theImage9 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][0]["poster_path"].string!
                    let theImage10 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][1]["poster_path"].string!
                    let theImage11 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][2]["poster_path"].string!
                    let theImage12 = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][3]["poster_path"].string!
                    let theImageURL9 = URL(string: theImage9)
                    let theImageURL10 = URL(string: theImage10)
                    let theImageURL11 = URL(string: theImage11)
                    let theImageURL12 = URL(string: theImage12)
                    
                    DispatchQueue.main.async{
                        if let ImageData9 = NSData(contentsOf: theImageURL9!) {
                            self.button9.setImage(UIImage(data: ImageData9 as Data), for: .normal)
                            self.id9 = String(swiftyJSON["results"][0]["id"].int!)
                        }
                        if let ImageData10 = NSData(contentsOf: theImageURL10!) {
                            self.button10.setImage(UIImage(data: ImageData10 as Data), for: .normal)
                            self.id10 = String(swiftyJSON["results"][1]["id"].int!)
                        }
                        if let ImageData11 = NSData(contentsOf: theImageURL11!) {
                            self.button11.setImage(UIImage(data: ImageData11 as Data), for: .normal)
                            self.id11 = String(swiftyJSON["results"][2]["id"].int!)
                        }
                        if let ImageData12 = NSData(contentsOf: theImageURL12!) {
                            self.button12.setImage(UIImage(data: ImageData12 as Data), for: .normal)
                            self.id12 = String(swiftyJSON["results"][3]["id"].int!)
                        }
                    }
                    
                    for title in theTitle {
                        let titles = title["title"].stringValue
                        //print(titles)
                    }
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        
        task3.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destVC: InfoViewController = segue.destination as! InfoViewController
        destVC.movieData = movieIDInput
    }

}

