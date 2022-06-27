//
//  appState.swift
//  VKTest
//
//  Created by Ilya Vasilev on 13.06.2022.
//

import Foundation

final class AppState {
    static let shared = AppState()
    private init() {}
    var isFirstEnrty: Bool = true {
        
        didSet {
///Сохраняем значение первого входа пользователя в наше приложение, записываем его в UserDefaults
            UserDefaults.standard.set(isFirstEnrty, forKey: "isFirstEnrty")
        }
    }
}
