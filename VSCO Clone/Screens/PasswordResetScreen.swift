//
//  PasswordResetScreen.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 9.01.2023.
//

import UIKit
import FirebaseAuth

class PasswordResetScreen: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func passwordResetButton(_ sender: Any) {
        if email.text != "" {
            Auth.auth().sendPasswordReset(withEmail: email.text!) { error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                }else {
                    self.makeAlertwithAction(title: "Check Your Mailbox", message: "We've sent a reset email to your email address. Please check your mailbox and reset your password.")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else {
            self.makeAlert(title: "Error", message: "You have to write your email.")
        }
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }
    
    func makeAlertwithAction(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) { UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(button)
        present(alert, animated: true)
    }
    

}
