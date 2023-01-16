//
//  HomeScreen.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 9.01.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class HomeScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var feedCollection: UICollectionView!
    
    let currentUser = Auth.auth().currentUser
    let firestore = Firestore.firestore()
    
    var posts = [PostModel]()
    var selectedPost : PostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        feedCollection.delegate = self
        feedCollection.dataSource = self

        getPostData()
        getUserData()
        

    }
    
    func getPostData () {
        firestore.collection("VSCO_Posts").order(by: "post_date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
            }else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.posts.removeAll()
                    for document in snapshot!.documents {
                        if let postedBy = document.get("posted_by") as? String {
                            if let postComments = document.get("vsco_post_comment_array") as? [String] {
                                if let postArray = document.get("vsco_post_url_array") as? [String] {
                                    if let date = document.get("post_date") as? Timestamp {
                                        if let timeDifference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                            if timeDifference >= 24 {
                                                self.firestore.collection("VSCO_Posts").document(document.documentID).delete { error in
                                                    if error != nil {
                                                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                                                    }
                                                }
                                            }else{
                                                let post = PostModel(postImage: postArray, postComment: postComments, postOwner: postedBy, timeDifference: 24 - timeDifference, postDate: date.dateValue())
                                                self.posts.append(post)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    self.feedCollection.reloadData()
                }
            }
        }
    }

    func getUserData () {
        
        if currentUser != nil {
            firestore.collection("Users").whereField("user_email", isEqualTo: currentUser!.email!).getDocuments { snapshot, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong!")
                }else {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        for document in snapshot!.documents {
                            if let userName = document.get("user_name") as? String {
                                if let userEmail = document.get("user_email") as? String {
                                    if let profilePicture = document.get("profile_picture") as? String {
                                        UserInfoSingleton.sharedUserInfo.userName = userName
                                        UserInfoSingleton.sharedUserInfo.email = userEmail
                                        UserInfoSingleton.sharedUserInfo.profilePicture = profilePicture
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = feedCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PostCell
        cell.userName.text = self.posts[indexPath.row].postOwner
        cell.comment.text = self.posts[indexPath.row].postComment[0]
        cell.postImage.sd_setImage(with: URL(string: posts[indexPath.row].postImage[0]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPost = posts[indexPath.row]
        self.performSegue(withIdentifier: "toPostVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostVC" {
            let destinationVC = segue.destination as? PostScreen
            destinationVC?.selectedPost = selectedPost
        }
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }


}
