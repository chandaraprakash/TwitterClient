//
//  TwitterViewController.swift
//  TwitterClient
//
//  Created by Kumar, Chandaraprakash on 9/28/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetsTableView: UITableView!
    
    var tweets = [Tweet]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.navigationController?.navigationItem.title = "Tweets"
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
        //refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tweetsTableView.addSubview(refreshControl)
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets!
            self.tweetsTableView.reloadData()
        })
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120.0
        
        //tweetsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading tweets.."
        hud.show(true)
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets!
            self.tweetsTableView.reloadData()
            self.refreshControl.endRefreshing()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        })

    }
    
    @IBAction func onLogoutAction(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    @IBAction func onNewTweetAction(sender: AnyObject) {
        var vc = storyboard?.instantiateViewControllerWithIdentifier("NewTweetNavigationController") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func onReplyAction(sender: AnyObject) {
        var indexPath = sender.tag
        var vc = storyboard?.instantiateViewControllerWithIdentifier("NewTweetViewController") as NewTweetViewController
        //vc.rep
    }
    
    
    @IBAction func onFavouriteAction(sender: AnyObject) {
        var indexPathRow = sender.tag
        var tweet = tweets[indexPathRow]
        Tweet.favourite(tweet.id!, completion: { (error: NSError?) -> Void in
            if(error != nil) {
                println("TwitterViewController: Favourite Failed")
                tweet.favorited! = 0
            } else {
                println("TwitterViewController: Favourite Success!!")
                tweet.favorited! = 1
                self.tweets[indexPathRow] = tweet
                var cell = self.tweetsTableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPathRow, inSection: 0)) as TweetCell
                cell.tweet = tweet
            }
        })
    }
    
    @IBAction func onRetweetAction(sender: AnyObject) {
        var indexPathRow = sender.tag
        var tweet = tweets[indexPathRow]
        Tweet.reTweet(tweet.id!, completion: {(error: NSError?) -> Void in
            if(error != nil) {
                println("TwitterViewController: retweet Failed..")
                tweet.retweeted! = 0
            } else {
                println("TwitterViewController: retweet Success..")
                tweet.retweeted! = 1
                self.tweets[indexPathRow] = tweet
                var cell = self.tweetsTableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPathRow, inSection: 0)) as TweetCell
                cell.tweet = tweet
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = self.tweets.count
        return rowsCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        var tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        cell.contentView.layoutSubviews()
        return cell
    }
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        self.view.endEditing(true)
        if(segue.identifier == "TweetDetailSegue") {
            println("Tweet Detail View Controller rendered..")
            var vc = segue.destinationViewController as UINavigationController
            if(vc.viewControllers[0] is TweetDetailViewController) {
                var destinaionVC = vc.viewControllers[0] as TweetDetailViewController
                let indexPath = self.tweetsTableView.indexPathForSelectedRow()?.row
                destinaionVC.tweet = self.tweets[indexPath!]
            }
        } else if(segue.identifier == "NewTweetSegue") {
            println("NewTweet View Controller rendered..")
            var vc = segue.destinationViewController as UINavigationController
            if(vc.viewControllers[0] is NewTweetViewController) {
                var destinaionVC = vc.viewControllers[0] as NewTweetViewController
                let indexPath = self.tweetsTableView.indexPathForSelectedRow()?.row
                //destinaionVC.us
            }

        }
    }
    
    
    //
    

}
