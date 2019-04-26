//
//  HomeViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 4/25/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var pop1: UIButton!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let apiKey = "0518529e7e2dd0cf9c39e55884e0a084"
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=" + apiKey)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            do {
                let decoder = JSONDecoder()
                // this line is only needed if all JSON keys are decoded
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(Item.self, from: data!)
                DispatchQueue.main.async{
                    let imageData = Item.results.poster
                    
                    
                }
            } catch { print(error) }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    struct Item: Decodable {
        let results: [Results]
    }
    struct Results: Decodable{
        let id: String
        let title: String
        let poster: String
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
