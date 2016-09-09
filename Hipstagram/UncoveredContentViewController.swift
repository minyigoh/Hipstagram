//  UncoveredContentViewController.swift
//  Hipstagram
//  For View Controllers where textfield-keyboard is concerned,subclass "UncoveredContentViewController".
//  Substitute default "UIViewController" with "UncoveredContentViewController".
//  Bind textField "Editing did Begin" & "Editing did End" to IBAction "textFieldEditingDidBegin" & "textFieldEditingDidEnd"
//  http://glaucocustodio.com/2015/09/26/content-locked-under-keyboard-another-approach-to-solve/
//  Created by Joshua Su on 09/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.


import UIKit

class UncoveredContentViewController: UIViewController {
    
    var activeField:UIView?
    var changedY = false
    var keyboardHeight : CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UncoveredContentViewController.keyboardViewWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UncoveredContentViewController.keyboardViewWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    
    func keyboardViewWillShow(sender: NSNotification) {
        
        let kbSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        
        keyboardHeight = kbSize!.height
        var aRect = self.view.frame;
        aRect.size.height = aRect.size.height - kbSize!.height - CGFloat(20);
        
        if activeField != nil && !CGRectContainsPoint(aRect, activeField!.frame.origin) {
            
            if (!changedY) {
                self.view.frame.origin.y -= keyboardHeight
            }
            changedY = true
        }
    }
    
    
    func keyboardViewWillHide(sender: NSNotification) {
        
        if changedY {
            
            self.view.frame.origin.y += keyboardHeight
        }
        changedY = false
    }
    
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    @IBAction func textFieldEditingDidBegin(sender: UITextField){
        //println("did begin")
        activeField = sender
    }
    
    
    @IBAction func textFieldEditingDidEnd(sender: UITextField) {
        //println("did end")
        activeField = nil
    }
}
