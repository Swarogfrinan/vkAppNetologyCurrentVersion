//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//
import UIKit
import StorageService
import SnapKit


final class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    weak var delegate: LogInUserCheckDelegate?
    private let userService: UserService
    private let inputName: String
    //MARK: - Private
    private let posts = PostModel.makeMockModel()
    //MARK: - Variables
    private var isAvatarOpen = false
    //MARK: - UI
    private let profileHeader = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return table

    }()
//MARK: Lifecycle
    init(userService: UserService, inputName: String) {
        self.userService = userService
        self.inputName = inputName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        if let user = userService.getUser(with: inputName) {
            profileHeader.setupUser()
            print("Name: \(user.userName), avatar: \(user.userAvatarImage).jgp, status: \(user.userStatus)")
        } else {
            profileHeader.setupUser()
            print("Error: \(inputName) isnt found")
        }
        
        customizeTestView()
        layout()
        setupGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        
    navigationController?.navigationBar.isHidden = true
    }

    //MARK: - Methods
    private func customizeTestView() {
        #if DEBUG
             view.backgroundColor = .systemMint
         #else
             view.backgroundColor = .systemBackground
         #endif
    }

    private func layout() {
        //layout constraints TableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Extension + UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return profileHeader }
        else { return nil }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 204 }
        else { return 0 }
    }
///stack view select - > photosViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, isAvatarOpen == false {
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: - Extension + UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        else { return posts[0].count }
    }
    
    //stackView and postTableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let photosCell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath)
            ///Возвращаем карусельку из первых 4 фотографий фотогаллереи.
            return photosCell
        } else {
            let postCell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            postCell.setupCell(model: posts[0][indexPath.row])
            ///Устанавливаем фильтры на фотографии
            switch indexPath.row {
            case 0:
                postCell.setupFilter(.noir)
            case 1:
                postCell.setupFilter(.fade)
            case 2:
                postCell.setupFilter(.chrome)
            case 3:
                postCell.setupFilter(.colorInvert)
                ///error
            default:
                break
            }
            ///Возвращаем посты пользователя.
            return postCell
        }
    }
    
}
//MARK: = Extension - Gestures and Animations
extension ProfileViewController {
    
    private var widthBackView: CGFloat {
        profileHeader.backView.bounds.width
    }
    
    private var heightBackView: CGFloat {
        profileHeader.backView.bounds.height
    }
    
    ///Установка жеста открытия аватарки на фулл-сайз.
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        profileHeader.avatarImageView.addGestureRecognizer(tapGesture)
    let closeGesture = UITapGestureRecognizer(target: self, action: #selector(closeActions))
        profileHeader.backView.addGestureRecognizer(closeGesture)
        profileHeader.closeButton.addGestureRecognizer(closeGesture)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeActions))
        swipeGesture.direction = .down
        swipeGesture.direction = .up
        profileHeader.avatarImageView.addGestureRecognizer(swipeGesture)
        profileHeader.backView.addGestureRecognizer(swipeGesture)
        
    }
    //open photo on tap
    @objc private func tapAction() {
        isAvatarOpen = true
        
        UIView.animate(withDuration: 0.31) {
            print("tapAction open avatar image")
            self.profileHeader.avatarImageView.layer.cornerRadius = 0
            self.profileHeader.avatarImageView.layer.borderWidth = 0
            self.profileHeader.widthAvatarImageView.constant = self.widthBackView
            self.profileHeader.heightAvatarImageView.constant = self.widthBackView
            self.profileHeader.leadingAvatarImageView.constant = 0
            self.profileHeader.topAvatarImageView.constant = (self.heightBackView - self.widthBackView) / 3
            self.profileHeader.layoutIfNeeded()
            self.profileHeader.avatarImageView.layer.zPosition = 1
            self.profileHeader.backView.isHidden = false
            self.profileHeader.closeButton.isHidden = false
            self.profileHeader.backView.alpha = 0.70
            self.tableView.isScrollEnabled = false
            
        } completion: { _ in
            
            
            UIView.animate(withDuration: 0.2) {
                self.profileHeader.closeButton.alpha = 1
        }
        }
    }
    
        ///close photo app
            @objc private func closeActions() {
                isAvatarOpen = false
                UIView.animate(withDuration: 0.3) {
                print("closeActions open avatar image")
                self.profileHeader.closeButton.alpha = 0
                    
            } completion: { _ in
                
                UIView.animate(withDuration: 0.2) {
                    self.profileHeader.avatarImageView.layer.cornerRadius = 50
                    self.profileHeader.avatarImageView.layer.borderWidth = 3
                    self.profileHeader.widthAvatarImageView.constant = 100
                    self.profileHeader.heightAvatarImageView.constant = 100
                    self.profileHeader.topAvatarImageView.constant = 16
                    self.profileHeader.leadingAvatarImageView.constant = 16
                    self.profileHeader.backView.alpha = 0
                    self.profileHeader.layoutIfNeeded()
                    self.tableView.isScrollEnabled = true
                }
            }
        }
//end
}
