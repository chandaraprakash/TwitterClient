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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onLogoutAction(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    @IBAction func onNewTweetAction(sender: AnyObject) {
        var vc = storyboard?.instantiateViewControllerWithIdentifier("NewTweetNavigationController") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
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
    
    
    
    

}
