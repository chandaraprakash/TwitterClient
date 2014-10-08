//
//  ContainerViewController.swift
//  TwitterClient
//
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tweetsButton: UIButton!
    @IBOutlet weak var mentionsButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var contentViewXConstraint: NSLayoutConstraint!

    var viewControllers: [UIViewController] = [TwitterViewController(nibName: nil, bundle: nil)]
    var homePageVC: UIViewController?
    
    var myStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideBarView.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        self.sideBarView.tintColor = UIColor.whiteColor()
        
        self.contentViewXConstraint.constant = 0
        var homePageVC = myStoryboard.instantiateViewControllerWithIdentifier("TweetsNavigationController") as? UIViewController
        self.activeViewController = homePageVC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
        println("didSwipe action performed")
        if(sender.state == .Ended) {
            UIView.animateWithDuration(0.35, animations: {
                self.contentViewXConstraint.constant = -160            })
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func onButtonTapAction(sender: UIButton) {
        if(sender == tweetsButton) {
            println("Tweet Button Tap")
            var homePageVC = myStoryboard.instantiateViewControllerWithIdentifier("TweetsNavigationController") as? UIViewController
            self.activeViewController = homePageVC
            
        } else if(sender == mentionsButton) {
            println("Mentions Button Tap")
            var mentionsVC = myStoryboard.instantiateViewControllerWithIdentifier("MentionsNavigationController") as? UIViewController
            self.activeViewController = mentionsVC
        } else if(sender == profileButton) {
            println("Profile Button Tap")
            var profileVC = myStoryboard.instantiateViewControllerWithIdentifier("ProfileNavigationController") as? UIViewController
            self.activeViewController = profileVC
        }
        
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.contentViewXConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    var activeViewController: UIViewController? {
        didSet(oldViewControllerOrNil) {
            if let oldVC = oldViewControllerOrNil {
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                newVC.view.frame = self.contentView.bounds
                self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
            
        }
    }

}
