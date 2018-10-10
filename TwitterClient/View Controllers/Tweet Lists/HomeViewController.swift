//
//  HomeViewController.swift
//  Chirpy
//
//  Created by Alex Ritchey on 10/6/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class HomeViewController: TweetsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getTweets {}
        
        TwitterClient.sharedInstance.currentAccount(success: { (user: User) in
            
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    override func getTweets(success: @escaping () -> ()) {
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweetList = tweets
            self.tableView.reloadData()
            success()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
