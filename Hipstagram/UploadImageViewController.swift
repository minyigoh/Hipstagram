//
//  UploadImageViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import Firebase
import Fusuma

class UploadImageViewController: UIViewController, FusumaDelegate {
    
    var cameraIsShown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.hasVideo = false // If you want to let the users allow to use video.
        
        switch cameraIsShown {
        case false:
            self.presentViewController(fusuma, animated: true, completion: nil)
            cameraIsShown = true
        default:
            return
        }
    }
    
    func presentHipstaTabBarController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = mainStoryboard.instantiateViewControllerWithIdentifier("HipstaTabBarController")
        presentViewController(tabBarController, animated: false, completion: nil)
        cameraIsShown = false
    }
    
    
    
    func fusumaImageSelected(image: UIImage) {
        // Converts UIImage into NSData
        let imageData: NSData = UIImageJPEGRepresentation(image, 0.25)!
        let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\(image)"
        
        // Adding metadata - type to the image
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Upload image to Firebase Storage
        // images >> User.uid >> image
        let uploadTask = DataService.imagesRef.child(filePath).putData(imageData, metadata: metaData, completion: { (metadata, error) in
            if (error != nil) {
                let error = NSError?()
                print("Error: \(error!.localizedDescription)")
            } else {
                // Obtain the metadata - download URL and converts it into String
                let downloadURL = metadata!.downloadURL()!.absoluteString
                
                // Storing download URL into Firebase Database
                // Hipsta Users >> User.uid >> hipstaPhotos >> photoID >> photoURL: ___
                DataService.userRef.child(FIRAuth.auth()!.currentUser!.uid).child("hipstaPhotos").childByAutoId().updateChildValues(["photoURL": downloadURL])
            }
        })
        
        uploadTask.observeStatus(.Success, handler: { (snapshot) in
            print("Upload completed")
        })
    }
    
    func fusumaClosed() {
        // If fusuma is closed (i.e. the "X" button is pressed), perform presentHipstaTabBarController
        presentHipstaTabBarController()
    }
    
    func fusumaDismissedWithImage(image: UIImage) {
        // If fusuma is dismissed with an image being selected or captured, perform presentHipstaTabBarController
        presentHipstaTabBarController()
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: NSURL) {}
    
    func fusumaCameraRollUnauthorized() {}

}