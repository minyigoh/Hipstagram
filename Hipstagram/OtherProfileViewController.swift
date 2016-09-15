//
//  OtherProfileViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 15/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import Firebase

class OtherProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var uploadedPhotos = [UIImage]()
    var hipstaUsername = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = hipstaUsername // To set current user's username
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HipstaPhotosCollectionViewCell
        
        //        DataService.userRef.child(hipsta.currentHipstaUid).child("hipstaPhotos").observeEventType(.ChildAdded, withBlock: { (snapshot) in
        //            let photoKey = snapshot.key
        //
        //            DataService.userRef.child(hipsta.currentHipstaUid).child("hipstaPhotos").child(photoKey).observeEventType(.Value, withBlock: { (photoSnapshot) in
        //
        //                let photoDict = photoSnapshot.value as! [String: AnyObject]
        //
        //                if let downloadString = photoDict["photoURL"] as? String {
        //
        //                    if let downloadURL = NSURL(string: downloadString) {
        //
        //                        if let photoData = NSData(contentsOfURL: downloadURL) {
        //
        //                            if let photo = UIImage(data: photoData) {
        //
        //                                self.uploadedPhotos.append(photo)
        //                                cell.userPhoto.image = self.uploadedPhotos[0]
        //                                collectionView.reloadData()
        //                                print("test")
        //                            }
        //                        }
        //                    }
        //                }
        //            })
        //
        //        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as! HipstaProfileHeaderCollectionReusableView
        return header
    }
}
