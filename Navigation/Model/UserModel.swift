//
//  UserModel.swift
//  VKTest
//
//  Created by Ilya Vasilev on 02.06.2022.
//

import Foundation
import UIKit

protocol UserService {
    func getUser(with name: String) -> User?
}

final class User {
    var userName: String
    var userStatus: String
    var userAvatarImage : String
    
    init(
        userName : String,
        userStatus: String,
        userAvatarImage: String
    ){
        self.userName = userName
        self.userStatus = userStatus
        self.userAvatarImage = userAvatarImage
    }
}



