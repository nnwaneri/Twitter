//
//  Tweet.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/24/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var name: String?
    var avatarUrl: URL?
    var handle: String?
    var id: Int?
    var isFavorited: Bool?

    init(dictionary: NSDictionary) {
        let userDict = dictionary["user"] as? NSDictionary
        
        text = dictionary["text"] as? String
        favoriteCount = (dictionary["favourite_count"] as? Int) ?? 0
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        name = userDict?["name"] as? String
        id = dictionary["id"] as? Int
        isFavorited = dictionary["favorited"] as? Bool
        
        if let formattedHandle = userDict?["screen_name"] as? String {
            handle = "@\(formattedHandle)"
        }
        
        if let avatarURLString = userDict?["profile_image_url"] as? String {
            avatarUrl = URL(string: avatarURLString.replacingOccurrences(of: "_normal", with: ""))!
        }
        
        if let timestampString = dictionary["created_at"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        return dictionaries.map { (dictionary) -> Tweet in
            return Tweet(dictionary: dictionary)
        }
    }
}
