//
//  SignUpScreen.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 8.01.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class SignUpScreen: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let dimView = UIView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dimView.backgroundColor = UIColor.black
        dimView.alpha = 0.5
        
        indicator.style = .large
        indicator.hidesWhenStopped = true
        
        profilePicture.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profilePicture.addGestureRecognizer(gestureRecognizer)

    }
    
    @objc func  selectImage () {
        let selectedImage = UIImagePickerController()
        selectedImage.delegate = self
        selectedImage.allowsEditing = true
        selectedImage.sourceType = .photoLibrary
        present(selectedImage, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePicture.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if email.text != "" && password.text != "" && userName.text != "" {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { result, error in
                self.indicator.startAnimating()
                self.view.addSubview(self.dimView)
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                }else {
                    let storage = Storage.storage()
                    let storageReference = storage.reference()
                    let mediaFolder = storageReference.child("profile_pictures")
                    
                    if let data = self.profilePicture.image?.jpegData(compressionQuality: 0.5) {
                        let imageReference = mediaFolder.child("\(self.email.text!).jpg")
                        imageReference.putData(data) { metadata, error in
                            if error != nil {
                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                            }else {
                                imageReference.downloadURL { url, error in
                                    if error != nil {
                                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                                    }else {
                                        let imageUrl = url?.absoluteString
                                        let firestore = Firestore.firestore()
                                        let firestoreuser = ["profile_picture" : imageUrl!, "user_email" : self.email.text!, "user_name" : self.userName.text!,  "account_date" : FieldValue.serverTimestamp()] as [String : Any]
                                        firestore.collection("Users").document(self.email.text!).setData(firestoreuser, merge: true)
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }else {
            self.makeAlert(title: "Error", message: "Please fill in the blanks!")
        }
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }

}
