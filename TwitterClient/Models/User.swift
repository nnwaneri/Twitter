//
//  User.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/24/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class User: NSObject {
    static let userDidLogoutNotification: Notification.Name = Notification.Name(rawValue: "UserDidLogout")

    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var bio: String?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)!
        }
        
        bio = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    static var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
}
