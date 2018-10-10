//
//  Profile.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/26/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class Profile: NSObject {
    var name: String?
    var avatarUrl: URL?
    var handle: String?
    var tweetsNumber: String?
    var followersNumber: String?
    var followingNumber: String?
    var bannerUrl: URL?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        if let followers = dictionary["followers_count"] as? Int {
            followersNumber = followers.description
        }
        
        if let tweetCount = dictionary["statuses_count"] as? Int {
            tweetsNumber = tweetCount.description
        }
        
        if let following = dictionary["friends_count"] as? Int {
            followingNumber = following.description
        }
        
        if let formattedHandle = dictionary["screen_name"] as? String {
            handle = "@\(formattedHandle)"
        }
        
        if let bannerURLString = dictionary["profile_banner_url"] as? String {
            bannerUrl = URL(string: bannerURLString)!
        }
        
        if let avatarURLString = dictionary["profile_image_url"] as? String {
            avatarUrl = URL(string: avatarURLString.replacingOccurrences(of: "_normal", with: ""))!
        }
    }
}
