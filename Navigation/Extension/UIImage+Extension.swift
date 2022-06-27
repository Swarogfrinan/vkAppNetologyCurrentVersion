//
//  UIImage+Extension.swift
//  Navigation
//
//  Created by Артем Свиридов on 01.04.2022.
//

import UIKit
private var leadingView = NSLayoutConstraint()
var topView = NSLayoutConstraint()
var widthiew = NSLayoutConstraint()
var heightView = NSLayoutConstraint()


extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
extension UIImageView {

    
    func tapZoom() {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tapGesture.numberOfTapsRequired = 2
      isUserInteractionEnabled = true
      addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            
            let positionAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
            positionAnimation.fromValue = sender.view?.center
            positionAnimation.toValue = CGPoint(x: sender.view!.center.x, y: sender.view!.center.y)
            sender.view?.layer.add(positionAnimation, forKey: nil)
            sender.view?.transform.scaledBy(x: 5, y: 5)
           sender.view?.layoutIfNeeded()
        print("tap one")
        }
    }
    
//    @objc private func tapOpenAction(_ sender: UITapGestureRecognizer) {
//        UIView.animate(withDuration: 0.3) {
//            sender.view?.layer.cornerRadius = 0
//            sender.view?.layer.borderWidth = 0
//            sender.view?.constant = self.widthBackView
//            sender.view?.constant = self.widthBackView
//            sender.view?.constant = 0
//            sender.view?.constant = (self.heightBackView - self.widthBackView) / 3
//            sender.view?.layoutIfNeeded()
//            sender.view?.layer.zPosition = 1
//            sender.view?.alpha = 0.70
//            self.tableView.isScrollEnabled = false
//        } completion: { _ in
//            UIView.animate(withDuration: 0.2) {
////                self.profileHeader.closeButton.alpha = 1
//        }
//        }
//    }

    
//MARK: - Pinch resize image gesture
    
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
