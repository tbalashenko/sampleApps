//
//  SplashAnimator.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 20.05.21.
//

import UIKit

protocol SplashAnimatorDescription: AnyObject {
    func animateAppearance()
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator: SplashAnimatorDescription {
    private let foregroundSplashWindow: UIWindow
    private let backgroundSplashWindow: UIWindow
    
    private let foregroundSplashViewController: SplashViewController
    private let backgroundSplashViewController: SplashViewController
    
    var degree = CGFloat(CGFloat.pi / 180)
    
    init(foregroundSplashWindow: UIWindow, backgroundSplashWindow: UIWindow) {
        self.foregroundSplashWindow = foregroundSplashWindow
        self.backgroundSplashWindow = backgroundSplashWindow
        
        guard
            let foregroundSplashViewController = foregroundSplashWindow.rootViewController as? SplashViewController,
            let backgroundSplashViewController = backgroundSplashWindow.rootViewController as? SplashViewController
        else {
            fatalError("Splash window doesn't have splash root view controller!")
        }
        
        self.foregroundSplashViewController = foregroundSplashViewController
        self.backgroundSplashViewController = backgroundSplashViewController
    }
    
    private func addRotationAnimation(to layer: CALayer, duration: TimeInterval, delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation()
        
        let tangent = layer.position.y / layer.position.x
        let angle = -1 * atan(tangent)

        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
        animation.fromValue = 0
        animation.toValue = angle
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        layer.add(animation, forKey: "transform")
    }
    
    private func addScalingAnimation(to layer: CALayer, duration: TimeInterval, delay: CFTimeInterval = 0) {
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        
        let width = layer.frame.size.width
        let height = layer.frame.size.height
        let coefficient: CGFloat = 18 / 667
        let finalScale = UIScreen.main.bounds.height * coefficient
        let scales = [1, 0.85, finalScale]
        
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.keyTimes = [0, 0.2, 1]
        animation.values = scales.map { NSValue(cgRect: CGRect(x: 0, y: 0, width: width * $0, height: height * $0)) }
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                     CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        layer.add(animation, forKey: "scaling")
    }
    
    func animateAppearance() {
        foregroundSplashWindow.isHidden = false
        
        self.foregroundSplashViewController.coinImage.rotate360Degrees(duration: 3)
        
        foregroundSplashViewController.coinImage.alpha = 0
        UIView.animate(withDuration: 0.15, animations: {
            self.foregroundSplashViewController.coinImage.alpha = 1
        })
    }
    
    func animateDisappearance(completion: @escaping () -> Void) {
        guard
            let window = UIApplication.shared.delegate?.window,
            let mainWindow = window
        else {
            fatalError("Application doesn't have a window!")
        }
        
        foregroundSplashWindow.alpha = 0
        backgroundSplashWindow.isHidden = false
        
        let mask = CALayer()
        mask.frame = foregroundSplashViewController.coinImage.frame
        mask.contents = SplashViewController.bigCoinImage.cgImage
        mainWindow.layer.mask = mask
        
        let maskBackgroundView = UIImageView(image: SplashViewController.bigCoinImage)
        maskBackgroundView.frame = mask.frame
        mainWindow.addSubview(maskBackgroundView)
        mainWindow.bringSubviewToFront(maskBackgroundView)
        
        CATransaction.setCompletionBlock {
            mainWindow.layer.mask = nil
            completion()
        }
        
        CATransaction.begin()
        
        mainWindow.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        UIView.animate(withDuration: 0.6, animations: {
            mainWindow.transform = .identity
        })
        
        [mask, maskBackgroundView.layer].forEach { layer in
            addScalingAnimation(to: layer, duration: 0.6)
            addRotationAnimation(to: layer, duration: 0.6)
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [], animations: {
            maskBackgroundView.alpha = 0
        }) { _ in
            maskBackgroundView.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundSplashViewController.coinImage.alpha = 0
        }
        
        CATransaction.commit()
    }
}
