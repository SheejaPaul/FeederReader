//
//  SearchTableViewController.swift
//  FeederReader
//
//  Created by Admin on 10/17/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var networkController = NetworkController()
    
    var searchTerm: String?
    var searchArticles = [NYTSearchArticle]()
    let searchResultsController = SearchResultsController()
    let searchController = UISearchController(searchResultsController: nil)
    var activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupNavBar()
        loadSearchArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        if (tabBarController?.tabBar.isHidden)! {
            tabBarController?.tabBar.isHidden = false
        }
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
        return searchArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchArticle = searchArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        cell.newsTitleLabel.text = searchArticle.headline.main
        cell.newsTimestampLabel.text = searchArticle.formattedPublishedDate
        
        cell.newsImageView.image = UIImage(named: "placeholder")
        if let url = URL(string: (searchArticle.feedImageUrl)) {
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

    // MARK: - Activity View
    
    func initActivityView() {
        activityView = Styles().loadingView()
        tableView.addSubview(activityView)
        activityView.center = tableView.center
    }
    
    func showActivityView() {
        activityView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideActivityView() {
        activityView.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        loadSearchArticles()
    }
    
    // MARK: - Search Articles API
    
    func loadSearchArticles() {
        showActivityView()
        searchTerm = ((searchController.searchBar.text != nil) && searchController.searchBar.text != "") ? searchController.searchBar.text : "trending"
        let textCount = searchTerm?.count ?? 0
        guard textCount >= 3 else { return }
        SearchResultsController().getNYTArticleSearchFeed(searchText: searchTerm!) { (searchResponse) in
            self.searchArticles = searchResponse.docs
            DispatchQueue.main.async {
                self.hideActivityView()
                self.tableView.reloadData(true)
            }
            
            // Register local notifications
            NotificationController.shared.requestPermissions()
        }
    }
    
    // MARK: - View Management
    
    func setupNavBar() {
        // Setup the nav bar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Topics"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        title = "Search".uppercased()
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
                let article = searchArticles[indexPath.row]
                newsDetailViewController.contentURLString = article.web_url
                newsDetailViewController.shortURLString = article.web_url
                newsDetailViewController.shareImage = cell.newsImageView.image
            }
        }
    }
}

    


