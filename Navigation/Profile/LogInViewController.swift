//
//  LoginViewController.swift
//  Navigation
//
//  Created by Илья Васильев on 29.03.2022.
//

import UIKit

protocol logInUserNameDelegate: AnyObject{
    func segueUserName(text: String)
}
protocol LogInUserCheckDelegate: AnyObject{
    func didUserCheck(login: String, password: String) -> Bool
    
}
class LogInViewController: UIViewController {
    
//func segueUserName(text: String) {
//        logTextField.text! = text
//        print(text)
//    }
    
  
//        if let login = Checker.shared.checkPassword(login: log, password: <#T##String#>)
//        if let pass = Checker.shared.checkPassword(login: logTextField.text!, password: passwordTextField.text!) as? String {
//            print(login, pass)
//            if pass == checker?.checkPassword(login: "Ilya", password: "1234") ?? nil {
//                return true
//            } else {
//                return false
//            }
//
//        }
    
    
    
    
//MARK: - Properties
    weak var delegate: logInUserNameDelegate?
    weak var logVCDelegate: LogInUserCheckDelegate?
    private let notificationCenter = NotificationCenter.default
    
    private let scrollView: UIScrollView =  {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        return image
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.backgroundColor = UIColor.systemGray6.cgColor
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.distribution = .fillEqually
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.layer.masksToBounds = true
        stack.axis = .vertical
        return stack
    }()

    private lazy var logTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Email or phone".localized()
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.ident(size: 10)
        textField.delegate = self
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Password".localized()
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.ident(size: 10)
        textField.delegate = self
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Log In".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showProfileButtonPressed), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(1), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .disabled)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .highlighted)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    //MARK: - Methods
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
///button
    @objc func showProfileButtonPressed() {
        print("логин пользователя не верный \(logTextField.text!), \(passwordTextField.text!)")
//        delegate?.segueUserName(text: logTextField.text!)
        guard let logVCDelegate = logVCDelegate,
              let login = logTextField.text,
              let password = passwordTextField.text
        else { return }
        
        if logVCDelegate.didUserCheck(login: login, password: password) {
            print("логин пользователя верный \(login), \(password)")
        let profileViewController = ProfileViewController()
            navigationController?.pushViewController(profileViewController, animated: true)
        }

    }
    

///customize view
    private func customizeView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }

    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImage, stackView, logInButton].forEach { contentView.addSubview($0) }
        [logTextField, passwordTextField].forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),

            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

//MARK: - Extensions
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

    
