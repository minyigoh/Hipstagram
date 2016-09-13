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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.hasVideo = false // If you want to let the users allow to use video.
        self.presentViewController(fusuma, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func fusumaImageSelected(image: UIImage) {
        let imageData: NSData = UIImageJPEGRepresentation(image, 0.25)!
        let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\(image)"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Upload image to the folder 'images'
        let uploadTask = DataService.imagesRef.child(filePath).putData(imageData, metadata: metaData, completion: { (metadata, error) in
            if (error != nil) {
                let error = NSError?()
                print("Error: \(error!.localizedDescription)")
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()!.absoluteString
                DataService.userRef.child(FIRAuth.auth()!.currentUser!.uid).child("hipstaPhotos").childByAutoId().updateChildValues(["photoURL": downloadURL])
            }
        })
        
        uploadTask.observeStatus(.Success, handler: { (snapshot) in
            print("Upload completed")
        })
    }
    

    
    func fusumaDismissedWithImage(image: UIImage) {
        // Present ImageFeedViewController
//        let imageFeedViewController = ImageFeedViewController()
//        presentViewController(imageFeedViewController, animated: true, completion: nil)
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: NSURL) {
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }

}