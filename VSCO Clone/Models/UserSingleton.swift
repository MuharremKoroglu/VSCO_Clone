//
//  UserSingleton.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 13.01.2023.
//

import Foundation
import UIKit

class UserInfoSingleton {
    
    static let sharedUserInfo = UserInfoSingleton()
    
    var profilePicture = ""
    var email = ""
    var userName = ""
    

    private init () {}
}
