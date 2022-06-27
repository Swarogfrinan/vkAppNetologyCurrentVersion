//
//  UserModel.swift
//  VKTest
//
//  Created by Ilya Vasilev on 02.06.2022.
//

import Foundation
import UIKit

class User {
    var userName: String
    var userStatus: String
    var userAvatarImage : UIImage
    
    init(userName : String, userStatus: String, userAvatarImage: UIImage) {
        self.userName = userName
        self.userStatus = userStatus
        self.userAvatarImage = userAvatarImage
    }
}

//protocol UserService : AnyObject {
//    var property : User? { get set }
//    func someMethod(_ protocolName: String ) -> User
//
//    init(key property: UserService, protocolName: String)
//}

//class CurrentUserService: UserService {
//    required init(key property: UserService, protocolName: String) { }
//    var property: User?
//    
//    func someMethod(_ protocolName: String) -> User {
//        if protocolName == property?.userName {
//            return property!
//    } else {
//        return User.init(userName: "defaultUser", userStatus: "defaultStatus", userAvatarImage: UIImage(named: "")!)
//    }
//}
//}

