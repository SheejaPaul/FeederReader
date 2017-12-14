//
//  Styles.swift
//  FeederReader
//
//  Created by Admin on 10/14/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

enum TopStoriesType: String {
    case home
    case technology
    case sports
    static let allTypes = [home, technology, sports]
}

class Styles {
    
    func formattedDateForNavBarTitle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: Date())
    }
    
    func formattedDateForPublishedDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string)
    }
    
    func defaultBlueColor() -> UIColor {
        return UIColor(red: 0.090, green: 0.580, blue: 0.808, alpha: 1.00)
    }
    
    func formattedSectionTitle(_ type: TopStoriesType) -> String {
        var formattedString = ""
        switch type {
        case .home:
            formattedString = "Top Stories"
        case .technology:
            formattedString = "Technology"
        case .sports:
            formattedString = "Sports"
        }
        return formattedString
    }
    
    func urlEncodedString(_ string: String?) -> String {
        let unreserved = ":-._~/?=&,"
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: unreserved)
        return string?.addingPercentEncoding(withAllowedCharacters: allowed) ?? ""
    }
    
    func loadingView() -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.hidesWhenStopped = true
        return activityView
    }
}

extension UITableView {
    func reloadData(_ animated: Bool = true) {
        var sectionIndexes = [Int]()
        let numberOfSections = self.numberOfSections
        for i in 0..<numberOfSections {
            sectionIndexes.append(i)
        }
        self.reloadSections(IndexSet(sectionIndexes), with: .fade)
    }
}
