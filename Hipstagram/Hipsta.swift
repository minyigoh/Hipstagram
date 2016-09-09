//
//  Hipsta.swift
//  Hipstagram
//
//  Created by Joshua Su on 09/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import Foundation

class hipsta {
    
    static var currentHipstaUid: String {
        return NSUserDefaults.standardUserDefaults().objectForKey("userUID") as! String
    }
}