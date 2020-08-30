//
//  ViewExtensions.swift
//  VietFood
//
//  Created by HieuTDT on 8/30/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit

extension UIView {
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func dropShadow(shadowRadius: CGFloat) {
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.7
    }
}
