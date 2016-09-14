//
//  Profile.swift
//  Hipstagram
//
//  Created by Joshua Su on 13/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import Firebase

class Profile {
    var username = String()
    var uid = String()
    
    init?(snapshot: FIRDataSnapshot) {
        guard let dict = snapshot.value as? [String: AnyObject] else { return nil }
        uid = snapshot.key
        
        if let username = dict["username"] as? String {
            self.username = username
        } else {
            username = ""
        }
    }
}