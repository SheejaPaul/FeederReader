//
//  MoreNewsTableViewController.swift
//  FeederReader
//
//  Created by Admin on 10/17/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class MoreNewsTableViewController: UITableViewController {
    
    var results: [NYTResult] = []
    var allNewsFeed = [NYTNewsFeed]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        cell.newsTitleLabel.text = result.title
        cell.newsTimestampLabel.text = result.formattedPublishedDate
        
        cell.newsImageView.image = UIImage(named: "placeholder")
        if let url = URL(string: result.feedImageUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        cell.newsImageView.image = image
                    }
                }
            }).resume()
        }
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowNewsDetail" {
            let newsDetailViewController = segue.destination as! NewsDetailViewController
            if let cell = sender as? FeedTableViewCell {
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                let result = self.results[indexPath.row]
                newsDetailViewController.contentURLString = result.url
                newsDetailViewController.shortURLString = result.short_url
                newsDetailViewController.shareImage = cell.newsImageView.image
            }
        }
    }
}
