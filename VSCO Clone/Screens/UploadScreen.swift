//
//  UploadScreen.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 9.01.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class UploadScreen: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postComment: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.style = .large
        indicator.color = .white.withAlphaComponent(0.5)
        indicator.hidesWhenStopped = true

        postImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPostImage))
        postImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func  selectPostImage () {
        let selectedImage = UIImagePickerController()
        selectedImage.delegate = self
        selectedImage.allowsEditing = true
        selectedImage.sourceType = .photoLibrary
        present(selectedImage, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        
        self.indicator.startAnimating()
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let folder = storageReference.child("vsco_posts")
        
        if let data = postImage.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let vscoReference = folder.child("\(uuid).jpg")
            vscoReference.putData(data) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                }else {
                    vscoReference.downloadURL { url, error in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                        }else {
                           
                            let urlString = url?.absoluteString
                            
                            let firestore = Firestore.firestore()
                            firestore.collection("VSCO_Posts").whereField("posted_by", isEqualTo: UserInfoSingleton.sharedUserInfo.userName).getDocuments { snapshot, error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                                }else {
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        for document in snapshot!.documents {
                                            let documentID = document.documentID
                                            if var vscoPostUrlArray = document.get("vsco_post_url_array") as? [String] {
                                                if var vscoPostCommentArray = document.get("vsco_post_comment_array") as? [String] {
                                                    vscoPostUrlArray.append(urlString!)
                                                    vscoPostCommentArray.append(self.postComment.text!)
                                                    let extraPost = ["vsco_post_url_array" : vscoPostUrlArray , "vsco_post_comment_array" : vscoPostCommentArray] as [String : Any]
                                                    firestore.collection("VSCO_Posts").document(documentID).setData(extraPost, merge: true) { error in
                                                        if error != nil {
                                                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                                                        }else {
                                                            self.postImage.image = UIImage(named: "select-image")
                                                            self.postComment.text = ""
                                                            self.indicator.stopAnimating()
                                                            self.tabBarController?.selectedIndex = 0
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }else {
                                        let vscoPost = ["posted_by" : UserInfoSingleton.sharedUserInfo.userName, "vsco_post_url_array" : [urlString!], "vsco_post_comment_array" : [self.postComment.text!], "post_date" : FieldValue.serverTimestamp()] as [String : Any]
                                        firestore.collection("VSCO_Posts").addDocument(data: vscoPost) { error in
                                            if error != nil {
                                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                                            }else {
                                                self.postImage.image = UIImage(named: "select-image")
                                                self.postComment.text = ""
                                                self.indicator.stopAnimating()
                                                self.tabBarController?.selectedIndex = 0
                                                
                                                
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
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }
    

}
