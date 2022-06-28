//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Илья Васильев on 17.03.2022.
//
import UIKit
import SnapKit


class ProfileHeaderView: UIView  {
//MARK: - Properties
    
private var statusText : String?

public let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.isUserInteractionEnabled = true
        return image
}()

    public let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        ///"Zhong Xina"
        label.textColor = .black
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Waiting for something...".localized()
        label.textColor = .black
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.ident(size: 10)
        textField.delegate = self
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status".localized(), for: .normal)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.alpha = 0.8
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    //hidden options open photos
    let backView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//hidden view with photo
    let mySecondView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.alpha = 0
        view.backgroundColor = .systemBlue
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
        
    }()
    //Закрыть View
    let closeButton: UIButton = {
        let button = UIButton()
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: 35)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle", withConfiguration: buttonConfig), for: .normal)
        button.isHidden = true
        button.alpha = 0
        return button
    }()
    //avatar image view constraints
    var heightAvatarImageView = NSLayoutConstraint()
    var widthAvatarImageView = NSLayoutConstraint()
    var topAvatarImageView = NSLayoutConstraint()
    var leadingAvatarImageView = NSLayoutConstraint()
    var trailingAvatarImageView = NSLayoutConstraint()
    
    ///open full-sizu image constraints
    var heightOpenmageView = NSLayoutConstraint()
    var widthOpenImageView = NSLayoutConstraint()
    var topOpenImageView = NSLayoutConstraint()
    var leadingOpenmageView = NSLayoutConstraint()
    var trailingOpenImageView = NSLayoutConstraint()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetupKitView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetupKitView() {
        [avatarImageView, setStatusButton, fullNameLabel, statusLabel, statusTextField, backView, closeButton].forEach { addSubview($0) }
        let heightScreen : CGFloat = UIScreen.main.bounds.height
        let size = CGFloat(100)
        let indent = CGFloat(16)
        
        backView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.height.equalToSuperview().inset(heightScreen)
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
        }

        avatarImageView.snp.makeConstraints { maker in
            maker.size.equalTo(CGSize (width: size, height: size))
            maker.top.equalTo(snp.top).inset(indent)
            maker.leading.equalTo(snp.leading).inset(indent)
        }
        fullNameLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(indent)
            maker.leading.equalToSuperview().offset(138)
            maker.trailing.equalToSuperview().offset(-100)
    }
        statusLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(fullNameLabel.snp.leading).inset(10)
            maker.bottom.equalTo(fullNameLabel.snp.bottom).offset(10)
            maker.trailing.equalTo(fullNameLabel.snp.trailing)
        }
        statusTextField.snp.makeConstraints { maker in
            maker.size.equalTo(CGSize (width: 35, height: 35))
            maker.leading.equalTo(statusLabel)
            maker.top.equalTo(fullNameLabel.snp.bottom).inset(-indent)
            maker.trailing.equalToSuperview().inset(60)
        }
        setStatusButton.snp.makeConstraints { maker in
            maker.size.equalTo(CGSize (width: 35, height: 35))
            maker.leading.equalTo(snp.leading).offset(indent)
            maker.trailing.equalTo(snp.trailing).offset(-indent)
            maker.top.equalTo(statusTextField.snp.bottom).offset(50)
            maker.bottom.equalToSuperview().inset(indent)
        }
        closeButton.snp.makeConstraints { maker in
            maker.top.equalTo(backView.snp.top).inset(indent / 2)
            maker.trailing.equalTo(backView.snp.trailing).inset(-indent / 2)
            maker.size.equalTo(CGSize (width: size / 2, height: size / 2))
        }
       
    }
    //MARK: - Methods
    func setupUser(name: String = "unknown",
                   avatar: String = "unknown",
                   status: String = "Waiting for something..."
    ) {
        fullNameLabel.text = name
        avatarImageView.image = UIImage(named: avatar)
        statusLabel.text = status
    }
    //изменение текстового статуса Профиля.
    @objc func buttonPressed() {
        //Если текст статуса Профиля пустой - дефолт текст ожидания.
        guard let text = statusTextField.text, !text.isEmpty else {
            statusLabel.text = "Waiting for something...".localized()
            return
        }
        //Изменить текст лейбла и обнулить текст.филд
        statusLabel.text = statusText
        statusTextField.text = ""
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }

    private func layout() {
        //Стандартные размеры
//        let size = CGFloat(100)
        let indent = CGFloat(16)
        [avatarImageView, setStatusButton, fullNameLabel, statusLabel, statusTextField, backView, closeButton].forEach { addSubview($0) }
        let heightScreen : CGFloat = UIScreen.main.bounds.height
        NSLayoutConstraint.activate([
            heightAvatarImageView, widthAvatarImageView, topAvatarImageView, leadingAvatarImageView,
            
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: heightScreen),
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: indent / 2),
            closeButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -indent / 2),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: indent),
            fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 138),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -indent),

            statusTextField.heightAnchor.constraint(equalToConstant: 35),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor, constant: 0),
            statusTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: indent),
            statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),

            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor, constant: 10),
            statusLabel.bottomAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: indent),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 50),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -indent),
            setStatusButton.heightAnchor.constraint(equalToConstant: 35),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: indent),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
        ])
    }
}
//    import SwiftUI
//    struct SwiftUIController: UIViewControllerRepresentable {
//        typealias UIViewControllerType = ProfileViewController
//
//    //typealias UIViewControllerType = ProfileHeaderView
//        func makeUIViewController (context: Context) -> UIViewControllerType {
//    let viewController = UIViewControllerType()
//    return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//    struct SwiftUIController_Previews: PreviewProvider {
//        static var previews: some View {
//    SwiftUIController()
//    .previewInterfaceOrientation(.portraitUpsideDown)
//    }
//    }
//    }
//

//MARK: - Extensions + UITextFieldDelegate
extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}

