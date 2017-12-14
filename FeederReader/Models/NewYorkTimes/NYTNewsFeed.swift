//
//  NYTNewsFeed.swift
//  FeederReader
//
//  Created by Admin on 10/13/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import Foundation

struct NYTNewsFeed: Decodable {
    let section: String
    let results: [NYTResult]
}

struct NYTResult: Decodable {
    let title: String
    let url: String
    let short_url: String?
    let multimedia: [Multimedia]
    let published_date: String
    
    var titleImageUrl: String {
        get {
            for currentMultimedia in multimedia {
                if currentMultimedia.height == 140 && currentMultimedia.width == 210 {
                    return currentMultimedia.url
                }
            }
            return ""
        }
    }
    
    var feedImageUrl: String {
        get {
            for currentMultimedia in multimedia {
                if currentMultimedia.height == 150 && currentMultimedia.width == 150 {
                    return currentMultimedia.url
                }
            }
            return ""
        }
    }
    
    var formattedPublishedDate: String {
        var formattedString = ""
        if let publishedDate = Styles().formattedDateForPublishedDate(string: published_date) {
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

struct Multimedia: Decodable {
    let url: String
    let height: Int
    let width: Int
}
