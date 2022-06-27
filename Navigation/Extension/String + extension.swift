//
//  String + extension.swift
//  Navigation
//
//  Created by Ilya Vasilev on 05.05.2022.
//

import Foundation
 
extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
