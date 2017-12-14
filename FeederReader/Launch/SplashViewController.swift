//
//  SplashViewController.swift
//  FeederReader
//
//  Created by Admin on 10/9/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var animatedNewsImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            self.performSegue(withIdentifier: "LoadTabBarController", sender: nil)
        }
        
        guard let newsImage = UIImage.gif(name: "news") else {
            return
        }
        animatedNewsImageView.animationImages = newsImage.images
        animatedNewsImageView.animationDuration = newsImage.duration / 2
        animatedNewsImageView.animationRepeatCount = 1
        animatedNewsImageView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
