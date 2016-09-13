//
//  DataService.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 09/09/2016.


import Foundation
import Firebase
import FirebaseStorage

class DataService {
    static let storageRef = FIRStorage.storage().referenceForURL("gs://hipstagram-810b0.appspot.com")
    static let imagesRef = storageRef.child("images")
    static let testRef = imagesRef.child("")
    static let databaseRef = FIRDatabase.database().reference()
    static let userRef = databaseRef.child("Hipsta Users")
}

