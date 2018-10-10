//
//  MenuViewController.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/25/18.
//  Copyright © 2018 Alex Ritchey. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var initialLeftMargin: CGFloat!
    
    var tweetsNavigationController: UINavigationController!
    
    var contentViewController: UINavigationController! {
        didSet {
            view.layoutIfNeeded()
            contentView.addSubview(contentViewController.view)
            
            UIView.animate(withDuration: 0.3) {
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    var menuViewController: MenuViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        tweetsNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController

        contentViewController = tweetsNavigationController
        menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.hamburgerViewController = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            initialLeftMargin = leftMarginConstraint.constant
        }
        else if sender.state == UIGestureRecognizerState.changed {
            if translation.x > 0 {
                leftMarginConstraint.constant = initialLeftMargin + translation.x
            }
        }
        else if sender.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 50
                } else {
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
}

