//
//  APIRequestFetcher.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/13/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum NetworkError: Error {
    case failure
    case success
}

class APIRequestFetcher {
    var searchResults = [JSON]()
    let apiKey = "0518529e7e2dd0cf9c39e55884e0a084"
    
    func search(searchText: String, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
        
        let urlToSearch = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&query=" + searchText
        print(urlToSearch)
        
        Alamofire.request(urlToSearch).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            let results = json?["total_results"]["total_pages"].arrayValue
            guard let empty = results?.isEmpty, !empty else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(results, .success)
        }
    }
    
    func fetchImage(url: String, completionHandler: @escaping (UIImage?, NetworkError) -> ()) {
        Alamofire.request(url).responseData { responseData in
            
            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(image, .success)
        }
    }
}
