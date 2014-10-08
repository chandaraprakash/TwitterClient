//
//  ProfileViewController.swift
//  TwitterClient
//
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: User?
    var tweets = [Tweet]()

    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var profileImageThumbView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
        if self.user == nil {
            self.user = User.currentUser
        }
        
        self.nameLabel.text = user?.name
        self.screenNameLabel.text = "@\((user?.screenName)!)"
        self.profileImageThumbView.setImageWithURL(NSURL(string: user!.profileImgeUrl! as NSString))
        profileImageThumbView.layer.cornerRadius = 5;
        profileImageThumbView.clipsToBounds = true;
        
        println("user!.screenName! ------>>>> \(user!.screenName!)")
        TwitterClient.sharedInstance.getUserTimeline(user!.screenName!, completion: { (tweets, error) -> () in
            self.tweets = tweets!
            self.profileTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = profileTableView.dequeueReusableCellWithIdentifier("MyTweetCell") as TweetCell
        cell.tweet = tweets[indexPath.row]        
        return cell
    }

}
