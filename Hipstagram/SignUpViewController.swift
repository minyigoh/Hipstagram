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
    func hideKeyboardByTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
}


class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardByTap()
        print("I'm Hipsta")
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
                
                self.performSegueWithIdentifier("mainSegue", sender: nil)
                
                let firebaseRef = FIRDatabase.database().reference()
                let currentUserRef = firebaseRef.child("Hipsta Users").child(hipsta.uid)
                
                let userDict = ["username" : username, "email" : email]
                
                currentUserRef.setValue(userDict)
                
            }else {
                let alert = UIAlertController (title: "Failed to Hipsta", message: error?.localizedDescription, preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "Buzz Off", style: .Default , handler: nil)
                
                alert.addAction(dismissAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
}

