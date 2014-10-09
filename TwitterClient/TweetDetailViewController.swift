//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Kumar, Chandaraprakash on 9/30/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var detailTweetText: UILabel!
    @IBOutlet weak var detailThumView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    var tweet: Tweet?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailThumView.setImageWithURL(NSURL(string: tweet!.user!.profileImgeUrl!))
        detailTweetText.text = tweet!.text!
        nameLabel.text = user?.name
        screenNameLabel.text = user?.screenName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
