//
//  LoginFactory.swift
//  VKTest
//
//  Created by Ilya Vasilev on 27.06.2022.
//

import Foundation
protocol LoginFactory {
    func getLoginInspector() -> LoginInspector
}

final class loginFactoryImp: LoginFactory {
    func getLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
    
}

final class LoginManager {
    static func makeLoginFactory() -> LoginFactory {
        loginFactoryImp()
    }
}
