//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Kumar, Chandaraprakash on 9/27/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

let twitterConsumerKey = "du4mZl9ZtHHkn0U10RhjXsntJ"
let twitterConsumerSecret = "8lAezmC1xIVk6qfN5HQ9ESerJsdqUUjqCksb9uFVsdJUrxf3WA"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey,   consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        //get tweets
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println("home_timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            /*for tweet in tweets {
                println("text: \(tweet.text) created: \(tweet.createdAt)")
            }*/
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error hetting home_timeline")
                completion(tweets: nil, error: error)
        })
    }
   
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterDemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            
            println("Got Request Token: \(requestToken.token)")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL)
            
            }) { (error: NSError!) -> Void in
                println("Error getting request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        
        //get access token for oauth
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: {(accessToken: BDBOAuthToken!) -> Void in
            println("Got the Access Token: \(accessToken)")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //verify user
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("user: \(response)")
                var user = User(dictionary: response as NSDictionary)
                User.currentUser = user
                println("user: \(user.name)")
                self.loginCompletion?(user:user, error: nil)
                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                println("Failed to receive Access Token")
                self.loginCompletion?(user: nil, error: error)
        }

    }
}
