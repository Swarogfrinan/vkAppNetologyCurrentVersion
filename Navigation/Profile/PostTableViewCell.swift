//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Артем Свиридов on 16.04.2022.
//

import UIKit
import StorageService
import iOSIntPackage


class PostTableViewCell: UITableViewCell {

    private  let imageProcessor = ImageProcessor()
    
    
    //MARK: - Properties
    private let author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()

    private let descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private let likes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let views: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let pic : UIImage = {
        let image = UIImage()
        return image
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeCell()
        layout()
        
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    private func customizeCell() {
        contentView.backgroundColor = .white
    }
    
    func setupFilter(_ filter: ColorFilter) {
        guard let image = postImage.image else { return }
        imageProcessor.processImage(sourceImage: image, filter: filter) {
            postImage.image = $0
        }
        }
    

    func setupCell(model: PostModel) {
        author.text = model.author
        postImage.image = UIImage(named: model.image)
        descriptionText.text = model.description
        likes.text = "Likes: \(model.likes)".localized()
        views.text = "Views: \(model.views)".localized()
    }

    private func layout() {
        [author, postImage, descriptionText, likes, views].forEach { contentView.addSubview($0) }

        let indent: CGFloat = 16

        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent),
            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent),
            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indent),

            postImage.topAnchor.constraint(equalTo: author.bottomAnchor, constant: indent),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descriptionText.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: indent),
            descriptionText.leadingAnchor.constraint(equalTo: postImage.leadingAnchor, constant: indent),
            descriptionText.trailingAnchor.constraint(equalTo: postImage.trailingAnchor, constant: -indent),

            likes.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: indent),
            likes.leadingAnchor.constraint(equalTo: descriptionText.leadingAnchor),
            likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent),

            views.topAnchor.constraint(equalTo: likes.topAnchor),
            views.trailingAnchor.constraint(equalTo: descriptionText.trailingAnchor),
            views.leadingAnchor.constraint(greaterThanOrEqualTo: likes.trailingAnchor, constant: indent),
            views.bottomAnchor.constraint(equalTo: likes.bottomAnchor)
        ])
    }
}
