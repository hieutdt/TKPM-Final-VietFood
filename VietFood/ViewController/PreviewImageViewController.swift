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
    var predictButton: ActionButton?
    var detectButton: ActionButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .primary
        self.title = "Preview"
        
        predictButton = ActionButton(title: "Dự đoán",
                                      titleColor: .white,
                                      titleHighlightColor: .white,
                                      backgroundColor: .primary,
                                      highlightBackgroundColor: .primaryHighlight) {
                                        self.predictImage()
        }
        
        detectButton = ActionButton(title: "Nhận diện",
                                    titleColor: .primary,
                                    titleHighlightColor: .primaryHighlight,
                                    backgroundColor: .white,
                                    highlightBackgroundColor: .primaryLight,
                                    action: {
                                        self.detectImage()
        })
        
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        self.view.addSubview(predictButton!)
        self.view.addSubview(detectButton!)
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        
        // Layouts
        let guide = view.safeAreaLayoutGuide
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: predictButton!.topAnchor, constant: -30)
        ])
        
        predictButton!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            predictButton!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            predictButton!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            predictButton!.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            predictButton!.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        detectButton!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detectButton!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            detectButton!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            detectButton!.topAnchor.constraint(equalTo: predictButton!.bottomAnchor, constant: 10),
            detectButton!.heightAnchor.constraint(equalToConstant: 60),
            detectButton!.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10)
        ])
    }
    
    func predictImage() {
        let vc = AnalyzeViewController()
        vc.image = imageView.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func detectImage() {
        let vc = AnalyzeViewController()
        vc.image = imageView.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
