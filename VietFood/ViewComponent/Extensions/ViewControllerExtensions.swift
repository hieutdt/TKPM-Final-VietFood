//
//  ViewControllerExtensions.swift
//  VietFood
//
//  Created by Trần Đình Tôn Hiếu on 9/1/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    func showEmbeddedLoading(text: String) {
        let whiteView = UIView(frame: self.view.frame)
        whiteView.backgroundColor = .white
        self.view.addSubview(whiteView)
        
        SVProgressHUD.setContainerView(whiteView)
        SVProgressHUD.setBackgroundColor(.white)
        if text != "" {
            SVProgressHUD.show(withStatus: text)
        } else {
            SVProgressHUD.show()
        }
    }
    
    func hideEmbeddedLoading() {
        SVProgressHUD.dismiss()
    }
}
