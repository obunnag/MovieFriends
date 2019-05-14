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
    
    var movieIDInput: String = ""
    
    private var searchResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let apiFetcher = APIRequestFetcher()
    private var previousRun = Date()
    private let minInterval = 0.05
    
    var query: String = ""

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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchTableViewCell

        // Configure the cell...
        
        cell.mTitle.text = searchResults[indexPath.row]["title"].string!
        //self.movieIDInput = String(searchResults[indexPath.row]["id"].int!)
        if self.searchResults[indexPath.row]["poster_path"].string?.isEmpty ?? true {
            cell.mImage.image = UIImage(named: "default")
        } else {
            apiFetcher.fetchImage(url: "https://image.tmdb.org/t/p/w500" + searchResults[indexPath.row]["poster_path"].string!, completionHandler: { image, _ in
                cell.mImage.image = image
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movieIDInput = String(searchResults[indexPath.row]["id"].int!)
        performSegue(withIdentifier: "searchSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destVC: InfoViewController = segue.destination as! InfoViewController
        destVC.movieData = movieIDInput
    }
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
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }

}
