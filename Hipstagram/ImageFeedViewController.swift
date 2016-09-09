//
//  ImageFeedViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit

class ImageFeedViewController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var imageFeedTableView: UITableView!

    var listOfImages = [String] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchHipstas()
      
    }
    

//     MARK: - Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listOfImages.count
        return listOfImages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageFeedCell")!
        let image = listOfImages[indexPath.row]
        cell.textLabel?.text = image
        return cell
    }
}
