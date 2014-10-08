//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Kumar, Chandaraprakash on 9/28/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileThumbView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    var tweet: Tweet! {
        willSet(newTweet) {
            self.nameLabel.text = newTweet.user?.name
            self.screenNameLabel.text = "@\((newTweet.user?.screenName)!)"
            self.tweetTextLabel?.text = newTweet.text
            self.profileThumbView.setImageWithURL(NSURL(string: newTweet.user!.profileImgeUrl! as NSString))
            profileThumbView.layer.cornerRadius = 5;
            profileThumbView.clipsToBounds = true;
            newTweet.user?.name
            
            if(newTweet.favorited == 1) {
                self.favouriteButton.enabled = false
                var favButtonImage = UIImage(named: "favorite_on.png") as UIImage
                self.favouriteButton.setImage(favButtonImage, forState: UIControlState.Disabled)
            } else {
                self.favouriteButton.enabled = true
                var favButtonImage = UIImage(named: "favorite.png") as UIImage
                self.favouriteButton.setImage(favButtonImage, forState: UIControlState.Normal)
            }
            
            if(newTweet.retweeted == 1) {
                self.retweetButton.enabled = false
                var retweetButtonImage = UIImage(named: "retweet_on.png") as UIImage
                self.retweetButton.setImage(retweetButtonImage, forState: UIControlState.Disabled)
            } else {
                self.retweetButton.enabled = true
                var retweetButtonImage = UIImage(named: "retweet.png") as UIImage
                self.retweetButton.setImage(retweetButtonImage, forState: UIControlState.Normal)
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
