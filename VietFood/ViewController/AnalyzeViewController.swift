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
        self.navigationController?.navigationBar.tintColor = .primary
        
        self.showEmbeddedLoading(text: "Đang phân tích, bạn chờ xíu nhé!")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.hideEmbeddedLoading()
        }
    }
    
    func requestAnalyze() {
        
    }
}
