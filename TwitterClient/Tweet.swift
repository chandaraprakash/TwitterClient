//
//  Tweet.swift
//  TwitterClient
//
//  Created by Kumar, Chandaraprakash on 9/27/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
    class func newTweet(tweetText: String, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        let params = ["status":tweetText] as NSMutableDictionary
        
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("Tweet.newTweet: Successfully Tweeted: \(response)")
            var tweet = Tweet(dictionary: response as NSDictionary)
            completion(tweet: tweet, error: nil)
            
            })
            { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Tweet.newTweet: Error submitting new Tweet: \(error)")
            completion(tweet: nil, error: error)
        }
    }
    
    
}
