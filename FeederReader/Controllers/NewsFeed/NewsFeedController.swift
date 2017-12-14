//
//  NewsFeedController.swift
//  FeederReader
//
//  Created by Admin on 10/13/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import Foundation

//func stringValue(completion: (String) -> ()) {
//    //completion("String")
//    anotherStringValue(completion: completion)
//}
//
//func anotherStringValue(completion: (String) -> ()) {
//    completion("Another String")
//}
//
//stringValue { (tempString) in
//    print(tempString)
//}
//print("something")

class NewsFeedController {
    
    let networkController = NetworkController()
    
    func getAllNYTNewsFeed(_ completion: @escaping ([NYTNewsFeed]) -> ()) {
        var allNewsFeed = [NYTNewsFeed]()
        
        let dispatchGroup = DispatchGroup()
        for sourceType in TopStoriesType.allTypes {
            let urlString = "https://api.nytimes.com/svc/topstories/v2/" + sourceType.rawValue + ".json?api-key=cdd5423982d543f5bf92171d0ddb164e"
            guard let nytNewsFeedUrl = URL(string: urlString) else { return }
            
            dispatchGroup.enter()
            networkController.getNYTNewsFeed(nytNewsFeedUrl, completion: { (newsFeed) in
                allNewsFeed.append(newsFeed)
                dispatchGroup.leave()
            })
            
            dispatchGroup.notify(queue: .main) {
                print("All functions complete 👍")
                completion(allNewsFeed)
            }
        }
    }
}
