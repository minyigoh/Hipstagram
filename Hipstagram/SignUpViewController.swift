//
//  ViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase



extension UIViewController {

    //Use hideKeyboardByTap for dismissing keyboard in any VCs
    func hideKeyboardByTap(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardView))
        
        // set to false to ensure other elements on the view receives user interaction
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView(){
        view.endEditing(true)
    }
}


class SignUpViewController: UncoveredContentViewController,UITextFieldDelegate {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.usernameTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
      
        self.hideKeyboardByTap()
        print("I'm Hipsta")
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
        
        guard
            let username = usernameTF.text,
            let email = emailTF.text,
            let password = passwordTF.text
        else{
            return
            }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user,error) in
            
            if let hipsta = user{
                
                NSUserDefaults.standardUserDefaults().setObject(hipsta.uid, forKey: "userUID")
                NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
                
                self.performSegueWithIdentifier("mainSegue", sender: nil)
                
                let currentHipstaRef = DataService.userRef.child(hipsta.uid)
                let hipstaDict = ["username" : username, "email" : email]
                currentHipstaRef.setValue(hipstaDict)
                
//                let firebaseRef = FIRDatabase.database().reference()
//                let currentUserRef = firebaseRef.child("Hipsta Users").child(hipsta.uid)
//                let userDict = ["username" : username, "email" : email]
//                currentUserRef.setValue(userDict)
                
            }else {
                
                let alert = UIAlertController (title: "Failed to Hipsta", message: error?.localizedDescription, preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "Buzz Off", style: .Default , handler: nil)
                alert.addAction(dismissAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
}

