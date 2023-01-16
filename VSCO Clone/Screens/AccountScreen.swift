//
//  AccountScreen.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 9.01.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage

class AccountScreen: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var userInfo = UserInfoSingleton.sharedUserInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.sd_setImage(with: URL(string: userInfo.profilePicture),placeholderImage: UIImage(named: "anon"))
        email.text = userInfo.email
        userName.text = userInfo.userName
    
    }
    

    @IBAction func logOutButton(_ sender: Any) {
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
            }catch {
                self.makeAlert(title: "Error", message: "Something went wrong!")
            }
        }else {
            self.makeAlert(title: "Error", message: "No user login found")
        }

    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }
    
}
