//
//  ProfileHeader.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/25/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class ProfileHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var tweetsNumber: UILabel!
    @IBOutlet weak var followersNumber: UILabel!
    @IBOutlet weak var followingNumber: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    
    var profileData: Profile? {
        didSet {
            name.text = profileData?.name
            followersNumber.text = profileData?.followersNumber
            tweetsNumber.text = profileData?.tweetsNumber
            followingNumber.text = profileData?.followingNumber
            
            avatar.setImageWith((profileData?.avatarUrl)!)
            avatar = Helpers.makeImageCircular(with: avatar)
            avatar.layer.borderWidth = 4.0
            avatar.layer.borderColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0).cgColor
            
            bannerImage.setImageWith((profileData?.bannerUrl)!)
            handle.text = profileData?.handle
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
