//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
//    let redDesign = ComponentManager.makeDesignFactory(design: .red)
//    lazy var redLabel = redDesign.createView(component: .label)
    
    private var loginInspector: LoginInspector
    init(_ loginInspector: LoginInspector) {
        self.loginInspector = loginInspector
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
//        let appstate = AppState.shared
//        appstate.isFirstEnrty = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.bool(forKey: "isFirstEnrty")
        print("В хранилище = \(UserDefaults.standard.bool(forKey: "isFirstEnrty"))")
//        view.addSubview(redDesign.createView(component: .imageView))
    }

    private func setupTabBar() {
        let feedViewController = createNavigationController(
            viewController: FeedViewController(),
            itemName: "Feed",
            itemImage: "house"
        )
        
        let logInViewController = createNavigationController(
            viewController: LogInViewController(),
            itemName: "Profile",
            itemImage: "person"
        )

        viewControllers = [feedViewController, logInViewController]
    }

    private func createNavigationController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName,
                                image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)),
                                tag: 0)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item

        return navigationController
    }
}
