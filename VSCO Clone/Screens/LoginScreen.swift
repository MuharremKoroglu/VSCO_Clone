//
//  ViewController.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 8.01.2023.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

class LoginScreen: UIViewController{

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    let dimView = UIView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dimView.backgroundColor = UIColor.black
        dimView.alpha = 0.5
        
        indicator.style = .large
        indicator.hidesWhenStopped = true
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        if email.text != "" && password.text != "" {
            
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { result, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                }else {
                    if result?.user.isEmailVerified == false {
                        self.makeAlert(title: "Check Your Mailbox", message: "Your email is not verified. We've sent a verification email.")
                        result?.user.sendEmailVerification(completion: { error in
                            if error != nil {
                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                            }
                        })
                    }else {
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                }
            }

        }else {
            self.makeAlert(title: "Error", message: "Please fill in the blanks!")
        }
        
    }
    
    @IBAction func googleSignInButton(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "Something went wrong!")
            }
            self.indicator.startAnimating()
            self.view.addSubview(self.dimView)
            let user = signInResult?.user
            if let accesToken = user?.accessToken {
                if let idToken = user?.idToken {
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accesToken.tokenString)
                        Auth.auth().signIn(with: credential) { result, error in
                            if error != nil {
                                print(error?.localizedDescription ?? "Something went wrong!")
                            }else {
                                DispatchQueue.global(qos: .background).async {
                                    if let userName = user?.profile?.name {
                                        if let email = user?.profile?.email {
                                            if let image = user?.profile?.imageURL(withDimension: 280) {
                                                
                                                let storage = Storage.storage()
                                                let storageReference = storage.reference()
                                                let mediaFolder = storageReference.child("profile_pictures")
                                                let imageReference = mediaFolder.child("\(email).jpg")
                                            
                                                do {
                                                    let data = try Data(contentsOf: image)
                                                        imageReference.putData(data) { metaData, error in
                                                            if error != nil {
                                                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                                                            }else {
                                                                imageReference.downloadURL { url, error in
                                                                    if error != nil {
                                                                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                                                                    }else {
                                                                        let url = url?.absoluteString
                                                                        let firestore = Firestore.firestore()
                                                                        let firestoreuser = ["profile_picture" : url!, "user_email" : email, "user_name" : userName, "account_date" : FieldValue.serverTimestamp()] as [String : Any]
                                                                        firestore.collection("Users").document(email).setData(firestoreuser, merge: true)
                                                                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                }catch {
                                                    self.makeAlert(title: "Error", message: "URL cannot convert to Data!")
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func passwordResetButton(_ sender: Any) {
        performSegue(withIdentifier: "toResetVC", sender: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }
    

}

