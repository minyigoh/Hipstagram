//
//  ImageFeedViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ImageFeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var imageFeedTableView: UITableView!

    var listOfImagePosts = [hipstaPhotos] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageFeedTableView.delegate = self
        self.imageFeedTableView.dataSource = self
    }
    
    func RetrieveHipstaPhotos() {
        
        // read from firebase database
        //.ChildAdded is like FOR loop
        DataService.userRef.child(hipsta.currentHipstaUid).child("hipstaPhotos").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            let hipstaPhotosKey = snapshot.key
            
            DataService.hipstaPhotosRef.child(hipstaPhotosKey).observeSingleEventOfType(.Value, withBlock: { (hipstaPhotosSnapshot) in
                if let loadedHipstaPhotos = hipstaPhotos(snapshot: hipstaPhotosSnapshot){
                    
                    self.listOfImagePosts.append(loadedHipstaPhotos)
                    self.imageFeedTableView.reloadData()
                }
            })
            
        })
            
    }
    
    func downloadHipstaPhotosWithUrl() {
        
        let hipstaPhotosRef = DataService.databaseRef.child("hipstaPhotos")
          }
        
    

//     MARK: - Table View Data Source
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            
            return listOfImagePosts.count
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func postIndex(cellIndex: Int) -> Int {
        
        return imageFeedTableView.numberOfSections - cellIndex - 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let hipstaPost = listOfImagePosts[postIndex(indexPath.section)]
        let cell = tableView.dequeueReusableCellWithIdentifier("ImagePostCell") as! ImagePostCell
        
        
//         cell.imgView.image = hipstaPost.photoUrl
        
        return cell
    }
    
    /*
    var myImages =  [String: UIImage]()
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemDetailTableViewCell
        let item = items[indexPath.section][indexPath.row]
        
        if let img: UIImage = myImages["\(indexPath.section)\(indexPath.row)"] {
            cell.image.image = img
        } else {
            if let uid = item["owner"] as? String {
                if let imageName = user["image"] {
                    let storage = FIRStorage.storage()
                    let storageRef = storage.referenceForURL("gs://bucket.com").child(user[id]).child(imageName)
                    storageRef.downloadURLWithCompletion { (URL, error) -> Void in
                        if (error != nil) {
                            cell.image = UIImage(named: "placeholder") // put default Image when failed to download Image
                        } else {
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.image.hnk_setImage(URL!)
                                // Store the image in to our cache
                                self.myImages["\(indexPath.section)\(indexPath.row)"]= cell.image.image
                            })
                        }
                    }
                }
            }
            
        }*/
    
    
    
    
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let hipstaPost = listOfImagePosts[postIndex(indexPath.section)]
//        if let img = hipstaPost.image {
//            let aspectRatio = img.size.height / img.size.width
//            return tableView.frame.size.width * aspectRatio + 80
//        }
//        return 280
//    }
//    
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 48
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
