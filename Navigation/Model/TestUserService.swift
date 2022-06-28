//
//  TestUserService.swift
//  VKTest
//
//  Created by Ilya Vasilev on 28.06.2022.
//

import Foundation
final class TestUserService {
    private let user = User(userName: "test Name",
                    userStatus: "test Status",
                    userAvatarImage: "testAvatar"
    )
    
}

extension TestUserService: UserService {
    func getUser(with name: String) -> User? {
      return  user
    }
    
    
}
