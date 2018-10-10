//
//  TwitterClient.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/24/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(
        baseURL: URL(string: "https://api.twitter.com")!,
        consumerKey: "ii2YtXgNbem47wzkxerBoDC6J",
        consumerSecret: "3W0r08U0JIKhRTmtXPbSt17LqVW63pcDrknfICIckCgQqI7F1E"
    )!
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping ()->(), failure: @escaping (Error)->()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "chirpy://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = URL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token as String)")!
            UIApplication.shared.open(url)
            
        }, failure: { (error: Error!) in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: URLSessionDataTask!, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask!, error: Error!) in
            failure(error)
        })
    }
    
    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/mentions_timeline.json", parameters: nil, success: { (task: URLSessionDataTask!, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask!, error: Error!) in
            failure(error)
        })
    }
    
    func profileTimeline(with twitterHandle: String!, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/user_timeline.json", parameters: ["screen_name": twitterHandle], success: { (task: URLSessionDataTask!, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask!, error: Error!) in
            failure(error)
        })
    }
    
    func userInfo(with twitterHandle: String!, success: @escaping (Profile) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/users/show.json", parameters: ["screen_name": twitterHandle], success: { (task: URLSessionDataTask!, response: Any?) in
            let dictionary = response as! NSDictionary
            let profileDetails = Profile(dictionary: dictionary)
            success(profileDetails)
        }, failure: { (task: URLSessionDataTask!, error: Error!) in
            failure(error)
        })
    }
    
    func favoriteTweet(with id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        post("/1.1/favorites/create.json",
             parameters: ["id": id],
             progress: nil,
             success: { (task, response) in
                success()
        }, failure: { (task, error) in
            failure(error)
        })
    }
    
    func unfavoriteTweet(with id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        post("/1.1/favorites/destroy.json",
             parameters: ["id": id],
             progress: nil,
             success: { (task, response) in
                success()
        }, failure: { (task, error) in
            failure(error)
        })
    }
    
    func composeTweet(with tweetContent: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        post("/1.1/statuses/update.json",
             parameters: ["status": tweetContent],
             progress: nil,
             success: { (task, response) in
                let tweetDict = response as! NSDictionary
                let newTweet = Tweet(dictionary: tweetDict)
                success(newTweet)
        }, failure: { (task, error) in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            let userDict = response as! NSDictionary
            let user = User(dictionary: userDict)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask!, error: Error!) -> Void in
            failure(error)
        })
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            
        }, failure: { (error: Error!) in
            print(error.localizedDescription)
            self.loginFailure?(error)
        })
    }
    
}
