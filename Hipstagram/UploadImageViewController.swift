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
    
    var listOfImagePosts = [hipstaPhotos] ()
    
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
                let hipstaPhotoDict = [
                    "photoURL": downloadURL,
                    "userID": hipsta.currentHipstaUid
                ]
               
                DataService.hipstaPhotosRef.childByAutoId().updateChildValues(hipstaPhotoDict) //generates uid for uploaded hipstaPhoto
                
                DataService.hipstaPhotosRef.observeSingleEventOfType(.Value, withBlock: { (hipstaPhotoSnapshot) in
                    let photoKey = hipstaPhotoSnapshot.key
                    let photoDict = [photoKey: "true"]
                    DataService.userRef.child(hipsta.currentHipstaUid).child("uploaded Photos").updateChildValues(photoDict)
                })

                
                
//                FIRDatabase.database().reference().child("Hipsta Users").child(hipsta.currentHipstaUid).child("Hipsta Photos").observeEventType(.ChildAdded, withBlock: { (uploadedPhotoSnapshot) in
//                    
//                    let hipstaPhotoKey = uploadedPhotoSnapshot.key
////                    let hipstaPhotoDict = [hipstaPhotoKey: "true"]
//                    
//                    
//                    FIRDatabase.database().reference().child("Hipsta Photos").child(hipstaPhotoKey).observeSingleEventOfType(.Value, withBlock: { (photoSnapshot) in
//                        if let hipstaPhoto = hipstaPhotos(snapshot: photoSnapshot){
//                            
//                        }
//                    })
//                    
//                })
                
                
                
                
              
                
                
                /*
                //writing hipstaPhotos into Firebase Database
                let hipstaPhotosDict = [
                    "photoUrl": downloadURL
                    //            "username" : hipsta.currentHipstaUsername,
                    "date" : NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle),
                    "createdAt" : NSDate().timeIntervalSince1970,
                    "userUID" : hipsta.currentHipstaUid
                ]
                
                
                let hipstaPhotosRef = DataService.databaseRef.child("hipstaPhotos").childByAutoId()
                
                hipstaPhotosRef.setValue(hipstaPhotosDict)
             */
                
                /*
                 change ["photoURL": downloadURL] to ([hipstaPhotosRef.key:true]) for the following -> UploadVC::
                 DataService.userRef.child(FIRAuth.auth()!.currentUser!.uid).child("hipstaPhotos").childByAutoId().updateChildValues(["photoURL": downloadURL])
                 */

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