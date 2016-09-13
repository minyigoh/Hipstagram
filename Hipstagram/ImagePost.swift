//
//  File.swift
//  Hipstagram
//
//  Created by Joshua Su on 13/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit

class ImagePost {
    let creator: String
    let timestamp: NSDate
    let image: UIImage?
    let caption: String?
    static var feed: [ImagePost]?
    
    init(creator: String, image: UIImage?, caption: String?) {
        self.creator = creator
        self.timestamp = NSDate()
        self.image = image
        self.caption = caption
    }

}

class ImagePostCell: UITableViewCell{
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
}

class ImagePostHeaderCell:UITableViewCell{
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var usernameButton: UIButton!
    
}