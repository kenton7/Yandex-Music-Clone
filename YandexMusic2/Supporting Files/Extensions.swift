//
//  Extensions.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import Foundation
import UIKit

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffectView, at: 0)
    }

    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
      }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

//MARK: - ScrollView
extension UIScrollView {

    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}

//MARK: - UITableView
extension UITableView {
     public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}


