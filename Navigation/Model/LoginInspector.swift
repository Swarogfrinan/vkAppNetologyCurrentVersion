//
//  LoginInspector.swift
//  VKTest
//
//  Created by Ilya Vasilev on 27.06.2022.
//

import Foundation
final class LoginInspector: LogInUserCheckDelegate {
    let checker = Checker.shared
    
    func didUserCheck(login: String, password: String) -> Bool {
        
        return checker.didUserCheck(login: login, password: password)
    }
}


