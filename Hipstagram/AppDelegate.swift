//
//  AppDelegate.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // +/- splash screen load time
        NSThread .sleepForTimeInterval(2)
        
        // set background image
        //[Info.plist->Supported interface orientations edited array[1,2]string as Portrait instead of Landscape
        self.window!.layer.contents = (UIImage(named: "hipsta.png")!.CGImage as! AnyObject)
        
        //Connect to Firebase by initializing code below
        FIRApp.configure()
        
        //Check for existing key in userdefaults,if yes,set rooVC as tabBarController named HipstaTabBarController
        if let _ =  NSUserDefaults.standardUserDefaults().objectForKey("userUID") as? String{
            
            let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            let tabBarController = storyBoard.instantiateViewControllerWithIdentifier ("HipstaTabBarController")
            
            self.window?.rootViewController = tabBarController
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

