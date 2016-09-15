//
//  ListOfHipstasViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 14/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit

class ListOfHipstasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listOfHipstas = [Profile]()
    var destination = OtherProfileViewController()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.userRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let userKey = snapshot.key
            if userKey != hipsta.currentHipstaUid {
                DataService.userRef.child(userKey).observeEventType(.Value, withBlock: { (userSnapshot) in
                    if let user = Profile(snapshot: snapshot) {
                        self.listOfHipstas.append(user)
                        self.tableView.reloadData()
                    }
                })
            } else {
            
            }
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHipstas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! HipstasTableViewCell
        let hipsta = listOfHipstas[indexPath.row]
        cell.usernameLabel.text = hipsta.username
        cell.followButton.layer.borderWidth = 1.0
        cell.followButton.layer.cornerRadius = 5.0
        cell.followButton.backgroundColor = UIColor.whiteColor()
        cell.followButton.tintColor = UIColor.blackColor()
        cell.contentView.bringSubviewToFront(cell.followButton)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedHipsta = listOfHipstas[indexPath.row]
        // Present profile view controller of the selected Hipsta
        destination.hipstaUsername = selectedHipsta.username
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        destination = segue.destinationViewController as! OtherProfileViewController
    }
}
