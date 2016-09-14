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

    var listOfImagePosts = [ImagePost] ()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        dispatch_async(dispatch_get_main_queue(),{
//            self.imageFeedTableView.reloadData()
//        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageFeedTableView.delegate = self
        self.imageFeedTableView.dataSource = self
    }
    
    func downloadImageWithUrl() {
        print("imageLoaded")
        
        
        let imagePostReference = DataService.userRef.observeEventType(.ChildAdded, withBlock: { (imagePostSnapshot) in
            
            if let downloadedImagePost = ImagePost(snapshot:imagePostSnapshot){
                
                self.listOfImagePosts.append(downloadedImagePost)
                self.imageFeedTableView.reloadData()
            }
        }
    )}

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
        cell.textLabel!.text = hipstaPost.username
//        cell.imgView.image = hipstaPost.image
//        cell.captionLabel.text = hipstaPost.caption
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
    
    
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let hipstaPost = listOfImagePosts[postIndex(indexPath.section)]
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
    
    /*
     
     Customize UITableView header section
     
    -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
    {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[list objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
    }
     
     swift version
     
     override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
     let label = UILabel(frame: CGRectMake(10, 5, tableView.frame.size.width, 18))
     label.font = UIFont.systemFontOfSize(14)
     label.text = list.objectAtIndex(indexPath.row) as! String
     view.addSubview(label)
     view.backgroundColor = UIColor.grayColor() // Set your background color
     
     return view
     }
     
    */
    
//    - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIImage *myImage = [UIImage imageNamed:@"loginHeader.png"];
//    UIImageView *imageView = [[[UIImageView alloc] initWithImage:myImage] autorelease];
//    imageView.frame = CGRectMake(10,10,300,100);
//    
//    return imageView;
//    
//    }
//    
//    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 100;
//    }
//
//    
    
    
//    - (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//    {
    // Set the text color of our header/footer text.
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    // Set the background color of our header/footer.
    // does not preserve gradient effect of original header
//    header.contentView.backgroundColor = [UIColor blackColor];
    
    // You can also do this to set the background color of our header/footer,
    //    but the gradients/other effects will be retained.
    // view.tintColor = [UIColor blackColor];
//    }

    
    
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let  cell : cellSectionHeader = tableView.dequeueReusableCellWithIdentifier("SectionHeader") as cellSectionHeader
//        return cell.contentView
//        //cellSectionHeader is my subclassed UITableViewCell
//    }
  
//    UIView *cellView = [[UIView alloc] init];
//    [cellView addSubview:cell];
//    tableView.tableHeaderView = cellView
    
    
    
//    class AdsHelper {
//        static let sharedInstance = AdsHelper()
//    }
    
}
