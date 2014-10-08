//
//  MentionsViewController.swift
//  TwitterClient
//
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mentionsTableView: UITableView!
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mentionsTableView.delegate = self
        mentionsTableView.dataSource = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)

        TwitterClient.sharedInstance.mentionsTweets(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets!
            self.mentionsTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = mentionsTableView.dequeueReusableCellWithIdentifier("MentionsCell") as MentionsCell
        var tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        cell.contentView.layoutSubviews()
        return cell
    }

    @IBAction func onCancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
