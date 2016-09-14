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
    
    
    @IBAction func onFollowButtonClicked(sender: UIButton) {

        switch isFollowing {
        case false:
            sender.setTitle("Following", forState: .Normal)
            isFollowing = true
        default:
            sender.setTitle("Follow", forState: .Normal)
            isFollowing = false
        }
    }
    
}
