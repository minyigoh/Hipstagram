//
//  DataService.swift
//  Hipstagram
//
//  Created by Joshua Su on 09/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DataService {
    
    static var rootRef = FIRDatabase.database().reference()
    static var hipstaRef = rootRef.child("Hipsta Users")
}