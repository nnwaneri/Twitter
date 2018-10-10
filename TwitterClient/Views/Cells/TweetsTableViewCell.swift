//
//  TweetsTableViewCell.swift
//  Chirpy
//
//  Created by Alex Ritchey on 9/25/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

@objc protocol TweetsTableViewCellDelegate {
    @objc optional func tweetCell(tweetCell: TweetsTableViewCell, handleProfileRedirect handle: String)
    @objc optional func tweetCell(tweetCell: TweetsTableViewCell, handleFavorite id: Int)
}

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var timeSince: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var retweetIcon: UIImageView!
    @IBOutlet weak var replyIcon: UIImageView!
    
    weak var delegate: TweetsTableViewCellDelegate?
    
    var tweet: Tweet! {
        didSet {
            if let avatarUrl = tweet.avatarUrl {
                avatar.setImageWith(avatarUrl)
                avatar = Helpers.makeImageCircular(with: avatar)
            }
            
            fullName.text = tweet.name
            tweetContent.text = tweet.text
            handle.text = tweet.handle
            
            if let favoriteState = tweet.isFavorited {
                if favoriteState == true {
                    favoriteIcon.image = #imageLiteral(resourceName: "favorited")
                }
                else {
                    favoriteIcon.image = #imageLiteral(resourceName: "favorite")
                }
            }
            
            let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(onTapAvatar))
            avatar.isUserInteractionEnabled = true
            avatar.addGestureRecognizer(tapAvatarGesture)
            
            let tapFavoriteGesture = UITapGestureRecognizer(target: self, action: #selector(onTapFavorite))
            favoriteIcon.isUserInteractionEnabled = true
            favoriteIcon.addGestureRecognizer(tapFavoriteGesture)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onTapAvatar() {
        delegate?.tweetCell!(tweetCell: self, handleProfileRedirect: tweet.handle!)
    }
    
    @objc func onTapFavorite() {
        delegate?.tweetCell!(tweetCell: self, handleFavorite: tweet.id!)
    }

}
