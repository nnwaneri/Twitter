//
//  MentionsViewController.swift
//  Chirpy
//
//  Created by Alex Ritchey on 10/7/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class MentionsViewController: TweetsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTweets {}
        
        TwitterClient.sharedInstance.currentAccount(success: { (user: User) in
            
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    override func getTweets(success: @escaping () -> ()) {
        TwitterClient.sharedInstance.mentionsTimeline(success: { (tweets: [Tweet]) in
            self.tweetList = tweets
            self.tableView.reloadData()
            success()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
}
