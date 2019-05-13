//
//  SearchTableViewController.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/6/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SearchTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var searchBar: UITextField!
    
    private var searchResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let apiFetcher = APIRequestFetcher()
    private var previousRun = Date()
    private let minInterval = 0.05
    
//    var total: Int = 0
//
//    let baseURL = "https://api.themoviedb.org/3/search/movie?api_key="
//    let apiKey = "0518529e7e2dd0cf9c39e55884e0a084"
    var query: String = ""
//    var mImage: UIImage? = nil
//    var mTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        setupTableViewBackgroundView()
        setupSearchBar()
        //self.searchBar.delegate = self as? UITextFieldDelegate
    }
    
    private func setupTableViewBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.text = "Oops, no results to show!"
        backgroundViewLabel.font.withSize(20)
        tableView.backgroundView = backgroundViewLabel
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for movie"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchTableViewCell

        // Configure the cell...
        
        cell.mTitle.text = searchResults[indexPath.row]["title"].string!
        print("hi")
        
//        if let url = "https://image.tmdb.org/t/p/w500" + searchResults[indexPath.row]["poster_path"].string! {
//            apiFetcher.fetchImage(url: url, completionHandler: { image, _ in
//                cell.mImage.image = image
//            })
//        }
        
        return cell
        
        
        //let url = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&query=" + query
        
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
//
//                    DispatchQueue.main.async{
//                        if let ImageData = NSData(contentsOf: theImageURL!) {
//                            self.mImage = UIImage(data: ImageData as Data)!
//                        }
//
//                        self.title = swiftyJSON["results"][indexPath.row]["title"].string!
//                        self.total = swiftyJSON["total_results"].int!
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
//        tableView.reloadData()
        //return cell
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        //textField.resignFirstResponder()
//        self.query = searchBar.text ?? ""
//        print(self.query + " searched!")
//        tableView.reloadData()
//        //getJSON()
//        return true
//    }
 
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
    


}

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }

        
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchResults(for: textToSearch)
        }
    }
    
    func fetchResults(for text: String) {
        print("Text Searched: \(text)")
        apiFetcher.search(searchText: text, completionHandler: {
            [weak self] results, error in
            if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            
            self?.searchResults = results
            self?.tableView.reloadData()
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }

}
