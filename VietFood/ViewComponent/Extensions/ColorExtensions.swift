//
//  ColorExtensions.swift
//  VietFood
//
//  Created by HieuTDT on 8/30/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit

extension UIColor {

    open class var primary: UIColor {
        get {
            UIColor(displayP3Red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        }
    }
    
    open class var primaryHighlight: UIColor {
        get {
            UIColor(displayP3Red: 203/255, green: 67/255, blue: 53/255, alpha: 1)
        }
    }
}
