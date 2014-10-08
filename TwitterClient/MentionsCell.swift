//
//  MentionsCell.swift
//  TwitterClient
//
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class MentionsCell: UITableViewCell {

    @IBOutlet weak var mentionsTweetLabel: UILabel!
    @IBOutlet weak var profileThumbView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    var tweet: Tweet! {
        willSet(newTweet) {
            self.nameLabel.text = newTweet.user?.name
            self.screenNameLabel.text = "@\((newTweet.user?.screenName)!)"
            self.mentionsTweetLabel?.text = newTweet.text
            self.profileThumbView.setImageWithURL(NSURL(string: newTweet.user!.profileImgeUrl! as NSString))
            profileThumbView.layer.cornerRadius = 5;
            profileThumbView.clipsToBounds = true;
            
            var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            tapGestureRecognizer.delegate = self
            profileThumbView.addGestureRecognizer(tapGestureRecognizer)
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
    
    func handleTap() -> Void {
        println("Tap on image..")
    }

}
