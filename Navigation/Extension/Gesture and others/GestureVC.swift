//
//  GestureVC.swift
//  Navigation
//
//  Created by Ilya Vasilev on 23.04.2022.
//

import UIKit

class GestureVC: UIViewController {

    private let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
private var leadingRedView = NSLayoutConstraint()
    private var topRedView = NSLayoutConstraint()
    private var widthRedView = NSLayoutConstraint()
    private var heightRedView = NSLayoutConstraint()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//layout()
//        setupGesture()
    }
    
    private func setupGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeGesture.direction = .right
//        redView.addGestureRecognizer(swipeGesture)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        
//        redView.addGestureRecognizer(tapGesture)
        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
//       redView.addGestureRecognizer(panGesture)
        
        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction))
//        redView.addGestureRecognizer(pinchGesture)
        
//        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationAction))
//        redView.addGestureRecognizer(rotationGesture)
        
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longAction))
        longGesture.minimumPressDuration = 2.0
//        redView.addGestureRecognizer(longGesture)
        
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgeAction))
        edgeGesture.edges = .right
        redView.addGestureRecognizer(edgeGesture)
        
    }
    
 
    
    @objc private func edgeAction(gesture : UIScreenEdgePanGestureRecognizer) {
        
        view.backgroundColor = [UIColor.yellow, UIColor.cyan, UIColor.green].randomElement()
    }
    
    @objc private func longAction(gesture : UILongPressGestureRecognizer) {
        UIView.animateKeyframes(withDuration: 4, delay:  0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                self.topRedView.constant = 250
                self.leadingRedView.constant = 150
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
            self.redView.layer.cornerRadius = 50
    }
        }
    }
    @objc private func rotationAction(gesture : UIRotationGestureRecognizer) {
        redView.transform = redView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
        
    @objc private func pinchAction(gesture: UIPinchGestureRecognizer) {
        redView.transform = redView.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1.0
    }
    
    @objc private func panAction(gesture: UIPanGestureRecognizer) {

//        let translation: CGPoint = gesture.translation(in: view)
//        switch gesture.state {
//
//        case .began:
//            var animator = UIViewPropertyAnimator(duration: 1.0, timingParameters: UISpringTimingParameters(mass: 2, stiffness: 30, damping: 7.0, initialVelocity: .zero))
//
//            animator.addAnimations {
//                self.redView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).rotated(by: .pi)
//                self.redView.center = CGPoint(x: self.redView.center.x + 250,
//                                              y: self.redView.center.y)
//            }
//
//            animator.startAnimation()
//            animator.pauseAnimation()
//
//case .changed:
//animator.fractionComplete = translation.x / view.bounds.size.width
//
//     case .ended:
//            if (redView.layer.presentation()?.position.x)! < view.center.x {
//                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//                animator.isReversed = true
//
//            } else {
//                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//            }
//
//        switch gesture.state {
//        case .changed:
//            let translation = gesture.translation(in: view)
//            print(translation)
//            topRedView.constant += translation.y
//            leadingRedView.constant += translation.x
//            gesture.setTranslation(.zero, in: view)
//        case .ended:
//            print("finish")
//            UIView.animate(withDuration: 3) {
////                self.leadingRedView.constant = 0
////                self.topRedView.constant = 30
//                self.view.layoutIfNeeded()
//            }
//        default:
//            break
//        }
    }
//
    @objc private func tapAction() {
        let rotateAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        rotateAnimation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 1.75 * Float.pi
        
        let positionAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        positionAnimation.fromValue = redView.center
        positionAnimation.toValue = CGPoint(x: view.bounds.width - 100, y: redView.center.y)
        
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 2.0
        groupAnimation.animations = [rotateAnimation, positionAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        redView.layer.add(groupAnimation, forKey: nil)
        redView.transform = CGAffineTransform(rotationAngle: CGFloat(1.75 * Float.pi))
        redView.layer.position = CGPoint(x: view.bounds.width - 100, y: redView.center.y)
        
        
        
          
        
    }
    
    @objc private func swipeAction() {
        UIView.animate(withDuration: 2) {
           
        }
        
        //duration - длительность, delay - задержка, usingSpringWithDamping - делает анимацию как пружинку, такой лёгкий отскок. initialSpringVelocity - начальная скорость пружинки, options - выбор анимации (плавное начало резкий конец или плавное начало плавный конец)
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.4,
                       options: .curveEaseIn) {
            self.leadingRedView.constant = UIScreen.main.bounds.width - self.widthRedView.constant
            self.topRedView.constant = 80
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.redView.layer.cornerRadius = 50
            }
        }
    }
    private func layout() {
        view.addSubview(redView)
        
        leadingRedView = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        topRedView = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        widthRedView = redView.widthAnchor.constraint(equalToConstant: 100)
        heightRedView = redView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([leadingRedView, topRedView, widthRedView , heightRedView])
        
        
    }

}
