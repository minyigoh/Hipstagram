//
//  SignInViewController.swift
//  Hipstagram
//
//  Created by Goh Min-Yi on 08/09/2016.
//  Copyright © 2016 Goh Min-Yi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardByTap()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonPressed(sender: UIButton) {
        
        guard
            let email = emailTF.text,
            let password = passwordTF.text
            else{
                return
                }
        
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if let hipsta = user{
                
                NSUserDefaults.standardUserDefaults().setObject(hipsta.uid, forKey: "userUID")
                
                self.performSegueWithIdentifier("mainSegue", sender: nil)
                
                }else {
                let alert = UIAlertController (title: "Failed to Hipsta", message: error?.localizedDescription, preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "Buzz Off", style: .Default , handler: nil)
                
                alert.addAction(dismissAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
}
