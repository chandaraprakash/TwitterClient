//
//  ViewController.swift
//  TwitterClient
//
//  Created by Kumar, Chandaraprakash on 9/27/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginAction(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if(user != nil) {
                //perform segue
                println("Login success, perform segue..")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                //error handling
                println("Login failed, cannot perform segue")
            }
        }
    }

}

