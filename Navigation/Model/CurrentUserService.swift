//
//  CurrentUserService.swift
//  VKTest
//
//  Created by Ilya Vasilev on 28.06.2022.
//

import Foundation

final class CurrentUserService {
    
    private var user: User
    
    init(_ user: User) {
    self.user = user
        
}
}

extension CurrentUserService: UserService {
    func getUser(with name: String) -> User? {
        return name == user.userName ? user : nil
    }
}
