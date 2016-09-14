//
//  ProfileViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = hipsta.currentHipstaUsername // To set current user's username
    }

    @IBAction func onSignoutButtonPressed(sender: UIBarButtonItem) {
        try! FIRAuth.auth()?.signOut()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userUID")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("username")
        
        let launchStoryboard = UIStoryboard(name: "LaunchStoryboard", bundle: NSBundle.mainBundle())
        let viewController = launchStoryboard.instantiateViewControllerWithIdentifier("SignUpViewController")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HipstaPhotosCollectionViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as! HipstaProfileHeaderCollectionReusableView
        return header
    }
    
}
