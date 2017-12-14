//
//  NYTSearchFeed.swift
//  FeederReader
//
//  Created by Admin on 10/17/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import Foundation

//https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=cdd5423982d543f5bf92171d0ddb164e&q=mobile%20application&sort=newest&fl=web_url,headline

struct NYTArticleSearchResponse: Decodable {
    let response: NYTSearchResponse
}

struct NYTSearchResponse: Decodable {
    let docs: [NYTSearchArticle]
}

struct NYTSearchArticle: Decodable{
    let web_url: String?
    let headline: Headline
    let pub_date: String?
    let multimedia: [SearchMultimedia]
    
    var titleImageUrl: String {
        get {
            for currentMultimedia in multimedia {
                if currentMultimedia.height == 126 && currentMultimedia.width == 190 {
                    return "https://static01.nyt.com/" + currentMultimedia.url
                }
            }
            return ""
        }
    }
    
    var feedImageUrl: String {
        get {
            for currentMultimedia in multimedia {
                if currentMultimedia.height == 75 && currentMultimedia.width == 75 {
                    return "https://static01.nyt.com/" + currentMultimedia.url
                }
            }
            return ""
        }
    }
    
    var formattedPublishedDate: String {
        guard let pubDate = pub_date else { return "" }
        var formattedString = ""
        if let publishedDate = Styles().formattedDateForPublishedDate(string: pubDate) {
            let unitFlags = Set<Calendar.Component>([.day, .hour, .minute])
            let components = Calendar.current.dateComponents(unitFlags, from: publishedDate, to: Date())
            let numberOfDays = components.day!
            let numberOfHours = components.hour!
            let numberOfMinutes = components.minute!
            
            if numberOfDays > 0 {
                formattedString = "\(numberOfDays) days ago"
            } else if numberOfHours > 0 {
                formattedString = "\(numberOfHours) hours ago"
            } else if numberOfMinutes > 0 {
                formattedString = "\(numberOfMinutes) mins ago"
            }
        }
        return formattedString
    }
}

struct Headline: Decodable {
    let main: String?
    let print_headline: String?
}

struct SearchMultimedia: Decodable {
    let url: String
    let height: Int
    let width: Int
}
