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

    var listOfImagePosts = [NSDictionary] ()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageFeedTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//     MARK: - Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if let feed = ImagePost.feed{
            return feed.count
        }else{
        return 0
        }
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func postIndex(cellIndex: Int) -> Int {
        
        return imageFeedTableView.numberOfSections - cellIndex - 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let hipstaPost = ImagePost.feed![postIndex(indexPath.section)]
        let cell = tableView.dequeueReusableCellWithIdentifier("ImagePostCell") as! ImagePostCell
        
        cell.captionLabel.text = hipstaPost.caption
        cell.imgView.image = hipstaPost.image
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let hipstaPost = ImagePost.feed![postIndex(indexPath.section)]
        if let img = hipstaPost.image {
            let aspectRatio = img.size.height / img.size.width
            return tableView.frame.size.width * aspectRatio + 80
        }
        return 280
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let hipstaPost = ImagePost.feed![postIndex(section)]
//        let headerCell = tableView.dequeueReusableCellWithIdentifier("ImagePostHeaderCell") as! ImagePostHeaderCell
//        if hipstaPost.creator == Profile.curre
//
//    }
    
    
}
