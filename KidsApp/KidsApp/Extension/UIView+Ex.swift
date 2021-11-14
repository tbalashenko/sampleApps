//
//  UIView+Ex.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 20.05.21.
//

import UIKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2 * duration) 
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    public static func reuse_id() -> String {
        return typeName(self)
    }
}
