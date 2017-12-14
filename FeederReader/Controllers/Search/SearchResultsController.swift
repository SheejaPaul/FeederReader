//
//  SearchResultsController.swift
//  FeederReader
//
//  Created by Admin on 10/17/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import Foundation

class SearchResultsController {
    
    let networkController = NetworkController()
    
    func getNYTArticleSearchFeed(searchText: String, _ completion: @escaping (NYTSearchResponse) -> ()) {
        let urlString = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=cdd5423982d543f5bf92171d0ddb164e&q=" + searchText + "&fl=web_url,headline,multimedia,pub_date"
        guard let articleSearchUrl = URL(string: Styles().urlEncodedString(urlString)) else { return }
        networkController.getNYTArticleSearch(articleSearchUrl, completion: completion)
    }
}
