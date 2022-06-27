//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Илья Васильев on 05.05.2022.
//

import UIKit
//ViewController фотогаллерея в которую мы переходим при нажатии на StackView (мини-версию галлереи)
class PhotosViewController: UIViewController {
//MARK: - Properties
let heightScreen : CGFloat = UIScreen.main.bounds.height
var images = [UIImage]()
private let photos = PhotosModel.makeMockModel()
    
let photoImageView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for element in 0...20 {
            if let image = UIImage(named: "photo\(element)") {
                images.append(image)
            }
        }
        customizeView()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    //MARK: - Methods
    private func customizeView() {
        view.backgroundColor = .systemBackground
        title = "Photo Gallery".localized()
    }

    private func layout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(model: photos[indexPath.row])
        return cell
    }


}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
//   private var extraview : UIView = UIView()
    
    
  //  sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 4 * sideInset) / 3
        return CGSize(width: width, height: width)
    }
//minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
//minimumInteritemSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
//insetForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
   
}

extension PhotosViewController: ExpandedCellDelegate {

    //Закрытие
    func pressedButton(view: expendedPhotoCell) {
    view.removeFromSuperview()
    }
            
//Выбор любого фото в галлерее и увеличение его
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let expendedCell = expendedPhotoCell()
                expendedCell.delegate = self
            //вызов чёрного View с картинкой
                self.view.addSubview(expendedCell)
        
        expendedCell.imageExpended.image = images[indexPath.row]
                
        //constraints
                NSLayoutConstraint.activate([
                    expendedCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    expendedCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    expendedCell.topAnchor.constraint(equalTo: view.topAnchor),
                    expendedCell.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        //update layout
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                }) { _ in
                    UIView.animate(withDuration: 0.3) {
                        //hidden
                        expendedCell.cancelButton.alpha = 1
                        expendedCell.backgroundColor = .black.withAlphaComponent(0.8)
                    }
                }
            }
        }
        
//
//
