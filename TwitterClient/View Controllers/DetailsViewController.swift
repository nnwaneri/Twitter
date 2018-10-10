//
//  DetailsViewController.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/25/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var replyIcon: UIImageView!
    @IBOutlet weak var retweetIcon: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let avatarUrl = tweet.avatarUrl {
            avatar.setImageWith(avatarUrl)
        }
        fullName.text = tweet.name
        tweetContent.text = tweet.text
        handle.text = tweet.handle
        retweetCount.text = tweet.retweetCount.description
        favoriteCount.text = tweet.retweetCount.description
        date.text = tweet.timestamp?.description
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
