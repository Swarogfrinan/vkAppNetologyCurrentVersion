//
//  expendedPhotoCell.swift
//  Navigation
//
//  Created by Ilya Vasilev on 11.05.2022.
//

import UIKit

//Делегат нажатия на кнопку.
protocol ExpandedCellDelegate: AnyObject {
    func pressedButton(view: expendedPhotoCell)
}

class expendedPhotoCell: UIView {
    weak var delegate: ExpandedCellDelegate?
    var pressCancelButton = UITapGestureRecognizer()
//Дополнительный View c чёрным экраном использующийся в галлерее фотографий PhotocollectionView
    lazy var imageExpended: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var cancelButton: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(systemName: "multiply.square")
        button.tintColor = .white
        button.alpha = 0
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        drawSelf()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func drawSelf() {
        self.addSubview(imageExpended)
        self.addSubview(cancelButton)
        
        
        NSLayoutConstraint.activate([
            imageExpended.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageExpended.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageExpended.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageExpended.heightAnchor.constraint(equalTo: self.heightAnchor),
            cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 30),
            cancelButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setupGesture() {
    pressCancelButton.addTarget(self, action: #selector(pressedButton(_:)))
    cancelButton.addGestureRecognizer(pressCancelButton)
        imageExpended.addGestureRecognizer(pressCancelButton)
    
    }
    @objc func pressedButton(_ gestureRecognizers: UITapGestureRecognizer) {
    delegate?.pressedButton(view: self)
        }
}
