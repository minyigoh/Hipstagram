//
//  ImagePost.swift
//  Hipstagram
//
//  Created by Joshua Su on 13/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class hipstaPhotos: NSObject {
    var uid: String
    var photoUrl: String
    var username: String
    var caption: String
    var date: String
    var createdAt: Double
    
    
 
    init?(snapshot: FIRDataSnapshot){
        
        guard let dict = snapshot.value as? [String: AnyObject] else {return nil}
        
        uid = snapshot.key
        
        
        if let dictPhoto = dict["photoUrl"] as? String{
            
            self.photoUrl = dictPhoto
        }else{
            self.photoUrl = ""
        }
        
        
        if let dictUsername = dict["username"] as? String{
            
            self.username = dictUsername
        }else{
            self.username = ""
        }
        
        
        if let dictCaption = dict["caption"] as? String{
            
            self.caption = dictCaption
        }else{
            self.caption = ""
        }
        
        
        if let dictDate = dict["date"] as? String{
            
            self.date = dictDate
        }else{
            self.date = ""
        }
        
        
        if let createdAt = dict["createdAt"] as? Double{
            self.createdAt = createdAt
        }else{
            self.createdAt = 0.0
        }
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