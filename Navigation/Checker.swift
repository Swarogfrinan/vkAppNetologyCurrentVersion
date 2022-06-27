//
//  Checker.swift
//  VKTest
//
//  Created by Ilya Vasilev on 16.06.2022.
//

import Foundation
final class Checker {
 
    private let login = "1"
    private let pswrd = "1"
    
    static let shared = Checker()
    
    private init() {}
    
}
extension Checker: LogInUserCheckDelegate {
    func didUserCheck(login: String, password: String) -> Bool {
        if self.login.hash == login.hash,
           pswrd.hash == password.hash {
            return true
        } else {
            return false
        }
    }
}
