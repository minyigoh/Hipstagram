//
//  DataService.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 09/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class DataService {
    static let storageRef = FIRStorage.storage().referenceForURL("gs://hipstagram-810b0.appspot.com")
    static let imagesRef = storageRef.child("images")
    static let testRef = imagesRef.child("")
}