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
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailThumView.setImageWithURL(NSURL(string: tweet!.user!.profileImgeUrl!))
        detailTweetText.text = tweet!.text!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
