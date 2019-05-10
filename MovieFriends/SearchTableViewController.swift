//
//  SearchTableViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/6/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var searchBar: UITextField!
    
    var total: Int = 0
    
    let baseURL = "https://api.themoviedb.org/3/search/movie?api_key="
    let apiKey = "0518529e7e2dd0cf9c39e55884e0a084"
    var query: String = ""
    var mImage: UIImage? = nil
    var mTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self as? UITextFieldDelegate
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return total
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchTableViewCell

        // Configure the cell...
        
        let url = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&query=" + query
        
        let request = URL(string: url)!
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            
            if error != nil {
                
                print("There was an error!")
            } else {
                do {
                    
                    let swiftyJSON = try JSON(data: data!)
                    
                    //Movie poster
                    let theImage = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][indexPath.row]["poster_path"].string!
                    let theImageURL = URL(string: theImage)
                    
                    
                    DispatchQueue.main.async{
                        if let ImageData = NSData(contentsOf: theImageURL!) {
                            self.mImage = UIImage(data: ImageData as Data)!
                        }
                        
                        self.title = swiftyJSON["results"][indexPath.row]["title"].string!
                        self.total = swiftyJSON["total_results"].int!
                    }
                    
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        
        task.resume()
        tableView.reloadData()
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //textField.resignFirstResponder()
        self.query = searchBar.text ?? ""
        print(self.query + " searched!")
        tableView.reloadData()
        //getJSON()
        return true
    }
 
//    func getJSON() {
//        let url = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&query=" + query
//
//        let request = URL(string: url)!
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (data, response, error) -> Void in
//
//            if error != nil {
//
//                print("There was an error!")
//            } else {
//                do {
//
//                    let swiftyJSON = try JSON(data: data!)
//
//                    //Movie poster
//                    let theImage = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][indexPath.row]["poster_path"].string!
//                    let theImageURL = URL(string: theImage)
//
//                    //Movie background
//                    let theBack = "https://image.tmdb.org/t/p/w500" + swiftyJSON["results"][indexPath.row]["backdrop_path"].string!
//                    let theBackURL = URL(string: theBack)
//
//                    DispatchQueue.main.async{
//                        if let ImageData = NSData(contentsOf: theImageURL!) {
//                            self.mImage = UIImage(data: ImageData as Data)!
//                        }
//
//                        self.title = swiftyJSON["title"].string!
//
//                    }
//
//
//                } catch {
//                    //Catch and handle the exception
//                }
//            }
//        }
//
//        task.resume()
//    }
    
 
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
