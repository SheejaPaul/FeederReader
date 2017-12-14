//
//  NetworkController.swift
//  FeederReader
//
//  Created by Admin on 10/13/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import Foundation

class NetworkController {
    
    let urlSession = URLSession.shared
    
    // New York Times News Feed API
    
    func getNYTNewsFeed(_ url: URL?, completion: @escaping (NYTNewsFeed) -> ()) {
        
        guard let feedUrl = url else { return }
        
        let task = urlSession.dataTask(with: feedUrl) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                let code = response.statusCode
                print("HTTP URL Response Code: ", code)
            }
            
            guard let data = data else { print("No data"); return }
            
            do {
                let newsFeed = try JSONDecoder().decode(NYTNewsFeed.self, from: data)
                completion(newsFeed)
            } catch let jsonError {
                print("Error decoding JSON response: ", jsonError)
            }
        }
        task.resume()
    }
    
    // New York Times Article Search API
    func getNYTArticleSearch(_ url: URL?, completion: @escaping (NYTSearchResponse) -> ()) {
        
        guard let articleSearchUrl = url else { return }
        
        let task = urlSession.dataTask(with: articleSearchUrl) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                let code = response.statusCode
                print("HTTP URL Response Code: ", code)
            }
            
            guard let data = data else { print("No data"); return }
            
            do {
                let nytArticleSearchResponse = try JSONDecoder().decode(NYTArticleSearchResponse.self, from: data)
                completion(nytArticleSearchResponse.response)
            } catch let jsonError {
                print("Error decoding JSON response: ", jsonError)
            }
        }
        task.resume()
    }
}
