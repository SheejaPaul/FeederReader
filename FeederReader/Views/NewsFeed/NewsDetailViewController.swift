//
//  NewsDetailViewController.swift
//  FeederReader
//
//  Created by Admin on 10/16/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit
import WebKit
import SafariServices
import Social

class NewsDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var contentURLString: String?
    var shortURLString: String?
    var shareImage: UIImage?
    var activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        self.webView.navigationDelegate = self
        initActivityView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = URL(string: contentURLString!) else { return }
        let urlRequest = URLRequest(url: url)
        
        showActivityView()
        self.webView.load(urlRequest)
        //self.webView.evaluateJavaScript("document.querySelector('.page-footer').remove();", completionHandler: { (any, error) in
        
        //})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - WKWebViewDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideActivityView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideActivityView()
    }
    
    // MARK: - Event Handlers
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let urlString = shortURLString else { return }
        let url = URL(string: urlString)
        
        let activityViewController = UIActivityViewController(activityItems: ["Trending news", url!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.message, .airDrop, .addToReadingList, .copyToPasteboard, .mail, .print, .assignToContact, .openInIBooks, .markupAsPDF]
        
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.barButtonItem = sender
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
