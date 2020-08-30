//
//  PreviewImageViewController.swift
//  VietFood
//
//  Created by HieuTDT on 8/30/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit

class PreviewImageViewController: UIViewController {

    public var image: UIImage? {
        didSet {
            imageView.image = self.image
        }
    }
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imageView)
        
        let guide = view.safeAreaLayoutGuide
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: guide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300  )
        ])
    }

}
