//
//  Factory.swift
//  VKTest
//
//  Created by Ilya Vasilev on 13.06.2022.
//

import Foundation
import UIKit
enum ComponentType {
    case textField
    case switchButton
    case button
    case label
    case imageView
}

protocol ComponentFactory {
    func createView(component: ComponentType) -> UIView
}

final class BlackComponentFactoryImp: ComponentFactory {
func createView(component: ComponentType) -> UIView {
    switch component {
    case .textField:
        let textField = UITextField()
            return textField
    case .switchButton:
        let switchButton = UISwitch()
        return switchButton
    case .button:
        let button = UIButton()
        return button
    case .label:
        let label = UILabel()
        return label
    case .imageView:
        let imageView = UIImageView()
        return imageView
    }
}
}

final class RedComponentFactoryImp: ComponentFactory {
func createView(component: ComponentType) -> UIView {
    switch component {
    case .textField:
        let textField = UITextField()
            return textField
    case .switchButton:
        let switchButton = UISwitch()
        return switchButton
    case .button:
        let button = UIButton()
        return button
    case .label:
        let label = UILabel()
        return label
    case .imageView:
        let imageView = UIImageView()
        return imageView
    }
}
}

final class ComponentManager {
    static func makeDesignFactory(design: Design) -> ComponentFactory {
        switch design {
        case .black:
            return BlackComponentFactoryImp()
        case .red:
            return RedComponentFactoryImp()
        }
    }
    enum Design {
        case black
        case red
    }
}
//
//final class RedButton: UIButton = {
//let button = UIButton()
//    return button
//}()
