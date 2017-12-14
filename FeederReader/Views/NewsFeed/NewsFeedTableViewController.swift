//
//  NewsFeedTableViewController.swift
//  FeederReader
//
//  Created by Admin on 10/13/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

let kNewsFeedSectionThreshold = 5

//let titleCellIdentifier = "TitleCell"
//let feedCellIdentifier = "FeedCell"

class NewsFeedTableViewController: UITableViewController, SectionFooterDelegate {
    
    let colors = [#colorLiteral(red: 1, green: 0.5546190143, blue: 0, alpha: 1), #colorLiteral(red: 0.02769589052, green: 0.7095260024, blue: 0.7943040729, alpha: 1), #colorLiteral(red: 0.864659071, green: 0.09174568206, blue: 0.0738395825, alpha: 1)]
    var allNewsFeed = [NYTNewsFeed]()
    var selectedSectionFooterIndex: Int = 0
    var activityView = UIActivityIndicatorView()
    
    /*
     - Section title
     - Source logo
     - result title
     - result image url
     - timestamp
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = Styles().formattedDateForNavBarTitle()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        loadNewsFeed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.tabBarController?.tabBar.isHidden)! {
            self.tabBarController?.tabBar.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.allNewsFeed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(self.allNewsFeed[section].results.count, kNewsFeedSectionThreshold)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = self.allNewsFeed[indexPath.section].results[indexPath.row]
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleTableViewCell
            cell?.newsTitleLabel.text = result.title
            cell?.newsTimestampLabel.text = result.formattedPublishedDate
            
            cell?.newsImageView.image = UIImage(named: "placeholder")
            if let url = URL(string: result.titleImageUrl) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data!) {
                            cell?.newsImageView.image = image
                        }
                    }
                }).resume()
            }
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell
            cell?.newsTitleLabel.text = result.title
            cell?.newsTimestampLabel.text = result.formattedPublishedDate
            
            cell?.newsImageView.image = UIImage(named: "placeholder")
            if let url = URL(string: result.feedImageUrl) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data!) {
                            cell?.newsImageView.image = image
                        }
                    }
                }).resume()
            }
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeader") as? SectionHeader
        cell?.sectionTitleLabel.textColor = self.colors[section]
        
        let title = Styles().formattedSectionTitle(TopStoriesType(rawValue: self.allNewsFeed[section].section)!)
        cell?.sectionTitleLabel.text = title.uppercased()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionFooter") as? SectionFooter
        cell?.backgroundColor = .white
        cell?.sectionFooterLabel.textColor = self.colors[section]
        
        let title = Styles().formattedSectionTitle(TopStoriesType(rawValue: self.allNewsFeed[section].section)!)
        cell?.sectionFooterLabel.text = "MORE " + title.uppercased()
        cell?.index = section
        cell?.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func sectionFooter(_ sectionFooter: SectionFooter, didSelectAt index: Int) {
        selectedSectionFooterIndex = index
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Activity View
    
    func initActivityView() {
        activityView = Styles().loadingView()
        view.addSubview(activityView)
        activityView.center = view.center
    }
    
    func showActivityView() {
        activityView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideActivityView() {
        activityView.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - News Feed API
    
    func loadNewsFeed() {
        showActivityView()
        NewsFeedController().getAllNYTNewsFeed { (newsFeed) in
            self.allNewsFeed = newsFeed
            DispatchQueue.main.async {
                self.hideActivityView()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowNewsDetail" {
            let newsDetailViewController = segue.destination as! NewsDetailViewController
            if let cell = sender as? UITableViewCell {
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                let result = self.allNewsFeed[indexPath.section].results[indexPath.row]
                newsDetailViewController.contentURLString = result.url
                newsDetailViewController.shortURLString = result.short_url
                
                if let titleCell = cell as? TitleTableViewCell {
                    newsDetailViewController.shareImage = titleCell.newsImageView.image
                }
                
                if let feedCell = cell as? FeedTableViewCell {
                    newsDetailViewController.shareImage = feedCell.newsImageView.image
                }
            }
        } else if segue.identifier == "ShowMoreNews" {
            let moreNewsTableViewController = segue.destination as! MoreNewsTableViewController
            moreNewsTableViewController.results = self.allNewsFeed[selectedSectionFooterIndex].results
            moreNewsTableViewController.title = Styles().formattedSectionTitle(TopStoriesType(rawValue: self.allNewsFeed[selectedSectionFooterIndex].section)!)
        }
    }
}
