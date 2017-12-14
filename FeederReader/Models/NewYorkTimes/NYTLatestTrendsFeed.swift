//
//  NYTLatestTrendsFeed.swift
//  FeederReader
//
//  Created by Admin on 10/19/17.
//  Copyright © 2017 Sheeja. All rights reserved.
// https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=cdd5423982d543f5bf92171d0ddb164e

import Foundation

struct NYTLatestTrendsFeed: Decodable {
    let results: [NYTrendResult]
}

struct NYTrendResult: Decodable {
    let url: String
    let title: String
    let published_date: String
}
//struct Media: Decodable {
//    let media: Media-Metadata
//}
//
//
//struct Media-Metadata: Decodable {
//    let url: String
//    let height: Int
//    let width: Int
//}

