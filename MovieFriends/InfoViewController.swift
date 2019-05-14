//
//  InfoViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/6/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit
import CoreData

class InfoViewController: UIViewController {
    
    var movieData: String = ""
    var idNum: String = ""
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mRelease: UILabel!
    @IBOutlet weak var mRuntime: UILabel!
    @IBOutlet weak var mOverview: UITextView!
    @IBOutlet weak var mBackground: UIImageView!
    @IBOutlet weak var mRating: UILabel!
    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var RatingView: RatingView!
    
    var chosenImage: UIImage?
    let apiKey = "0518529e7e2dd0cf9c39e55884e0a084"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        // Do any additional setup after loading the view.
        
    }
    
    func getJSON() {
        let url = "https://api.themoviedb.org/3/movie/" + movieData + "?api_key=" + apiKey
        let request = URL(string: url)!
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            
            if error != nil {
                
                print("There was an error!")
            } else {
                do {
                    
                    let swiftyJSON = try JSON(data: data!)
                    
                    var theImage = ""
                    var theImageURL: URL
                    var theBack = ""
                    var theBackURL: URL
                    
                    print(self.movieData)
                    
                    if swiftyJSON["backdrop_path"].string?.isEmpty ?? true || swiftyJSON["poster_path"].string?.isEmpty ?? true{
                        theImage = "https://image.tmdb.org/t/p/w500/jdXmMoREwmfZWxtqGyk5Zv0UB6r.jpg"
                        theImageURL = URL(string: theImage)!
                        theBack = "https://image.tmdb.org/t/p/w500/ZQixhAZx6fH1VNafFXsqa1B8QI.jpg"
                        theBackURL = URL(string: theBack)!
                    }
                    else{
                        //Movie poster
                        theImage = "https://image.tmdb.org/t/p/w500" + swiftyJSON["poster_path"].string!
                        theImageURL = URL(string: theImage)!
                        
                        //Movie background
                        theBack = "https://image.tmdb.org/t/p/w500" + swiftyJSON["backdrop_path"].string!
                        theBackURL = URL(string: theBack)!
                    }
                    DispatchQueue.main.async{
                        if let ImageData = NSData(contentsOf: theImageURL) {
                            self.mImage.image = UIImage(data: ImageData as Data)
                        }
                        if let BackgroundData = NSData(contentsOf: theBackURL) {
                            self.mBackground.image = UIImage(data: BackgroundData as Data)
                        }
                        self.mTitle.text = swiftyJSON["title"].string!
                        self.mRelease.text = "Released: " + swiftyJSON["release_date"].string!
                        self.mRuntime.text = String(swiftyJSON["runtime"].int ?? 120) + " min"
                        self.mOverview.text = swiftyJSON["overview"].string!
                        self.mRating.text = String(swiftyJSON["vote_average"].int!)
                        self.idNum = String(swiftyJSON["id"].int!)
                        
                        
                        self.RatingView.counter = Int(self.mRating.text!) ?? 3
                        print(self.mRating.text)
                    
                    }
                    
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        
        task.resume()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
        
        let movie = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        let imageData = self.mImage.image!.pngData();
        
        movie.setValue(self.mTitle.text, forKey: "title")
        movie.setValue(imageData, forKey: "moviePoster")
        movie.setValue(idNum, forKey: "id")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
        
        dismiss(animated: true, completion: nil)
    }
    

}
