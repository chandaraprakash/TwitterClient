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
    
    var tweet: Tweet! {
        willSet(newTweet) {
            self.tweetTextLabel?.text = newTweet.text
            self.profileThumbView.setImageWithURL(NSURL(string: newTweet.user!.profileImgeUrl! as NSString))
            profileThumbView.layer.cornerRadius = 5;
            profileThumbView.clipsToBounds = true;
            newTweet.user?.name
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
