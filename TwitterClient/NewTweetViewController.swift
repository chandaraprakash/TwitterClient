//
//  NewTweetViewController.swift
//  TwitterClient
//
//  Created by Kumar, Chandaraprakash on 9/30/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var newTweetTextView: UITextView!
    override func viewDidLoad() {
        println("NewTweetViewController view rendered")
        super.viewDidLoad()
        
        //header color
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTweetAction(sender: AnyObject) {
        var tweetText = newTweetTextView.text
        Tweet.newTweet(tweetText) { (tweet, error) -> () in
            if(error != nil) {
                println("NewTweetViewController: Error on submitting new tweet \(error)")
            } else {
                println("NewTweetViewController: Successfully submitted new Tweet")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
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
