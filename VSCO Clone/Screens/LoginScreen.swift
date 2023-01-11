//
//  ViewController.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 8.01.2023.
//

import UIKit

class LoginScreen: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    @IBAction func googleSignInButton(_ sender: Any) {
    }
    
    @IBAction func passwordResetButton(_ sender: Any) {
        performSegue(withIdentifier: "toResetVC", sender: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    

}

