//
//  ComposeTweetViewController.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/25/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapTweet(_ sender: Any) {
        if textView.text.count > 0 && textView.text.count < 140 {
            TwitterClient.sharedInstance.composeTweet(with: textView.text, success: { (tweet: Tweet) in
                print(tweet)
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
