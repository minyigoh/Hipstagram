//
//  HipstasTableViewCell.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 14/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit

class HipstasTableViewCell: UITableViewCell {
    
    var isFollowing = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    
    @IBAction func onFollowButtonClicked(sender: UIButton) {

        switch isFollowing {
        case false:
            sender.setTitle("Following", forState: .Normal)
            sender.layer.borderWidth = 1.0
            sender.layer.cornerRadius = 5.0
            sender.layer.borderColor = UIColor.whiteColor().CGColor
            sender.backgroundColor = UIColor.blackColor()
            sender.tintColor = UIColor.whiteColor()
            isFollowing = true
        default:
            sender.setTitle("Follow", forState: .Normal)
            sender.layer.borderWidth = 1.0
            sender.layer.cornerRadius = 5.0
            sender.layer.borderColor = UIColor.blackColor().CGColor
            sender.backgroundColor = UIColor.whiteColor()
            sender.tintColor = UIColor.blackColor()
            isFollowing = false
        }
    }
    
}
