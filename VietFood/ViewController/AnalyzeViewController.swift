//
//  AnalyzeViewController.swift
//  VietFood
//
//  Created by Trần Đình Tôn Hiếu on 9/1/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit
import SVProgressHUD

class AnalyzeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.show()
    }
}
