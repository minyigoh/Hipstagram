//
//  UploadImageViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import Firebase
import Photos

protocol UploadImageViewControllerDelegate {
    func uploadToImageFeed (image: UIImage)
}

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: ImageFeedViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        // Setting the imagePicker to be PhotoLibrary by default
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        // Retrieving the picked image's URL
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        
        let assets = PHAsset.fetchAssetsWithALAssetURLs([imageURL], options: nil)
        let asset = assets.firstObject
        asset?.requestContentEditingInputWithOptions(nil, completionHandler: { (contentEditingInput, info) in
            // Retrieving the picked image's local URL
            let imageFileURL = contentEditingInput?.fullSizeImageURL
            let imageName = imageFileURL?.lastPathComponent
            
            // Upload image to the folder 'images'
            let uploadTask = DataService.imagesRef.child(imageName!).putFile(imageFileURL!, metadata: nil) { metadata, error in
                if (error != nil) {
                    let error = NSError?()
                    print("Error: \(error!.localizedDescription)")
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata!.downloadURL
                }
            }
            
            uploadTask.observeStatus(.Success, handler: { (snapshot) in
                // Present the ImageFeedViewController
            })
        })
        dismissViewControllerAnimated(true, completion: nil)
    }
}
