//
//  MenuViewController.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/25/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let menuOptions = ["Profile", "Timeline", "Mentions"]
    
    var hamburgerViewController: HamburgerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.menuLabel.text = menuOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch indexPath.row {
            case 0:
                let profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
                let profileViewController = profileNavigationController.topViewController as! ProfileViewController
                profileViewController.handleName = "crystallinedex"
                
                hamburgerViewController.contentViewController = profileNavigationController
            case 1:
                hamburgerViewController.contentViewController = hamburgerViewController.tweetsNavigationController
            case 2:
                hamburgerViewController.contentViewController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController") as! UINavigationController
            default:
                return
        }
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
