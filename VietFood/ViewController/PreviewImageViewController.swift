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
    var sendButton: ActionButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButton = ActionButton(title: "Phân tích",
                                      titleColor: .white,
                                      titleHighlightColor: .white,
                                      backgroundColor: .primary,
                                      highlightBackgroundColor: .primaryHighlight) {
                                        self.analyzeImage()
        }
        
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        self.view.addSubview(sendButton!)
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        
        // Layouts
        let guide = view.safeAreaLayoutGuide
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: sendButton!.topAnchor, constant: -30)
        ])
        
        sendButton!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendButton!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            sendButton!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            sendButton!.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            sendButton!.heightAnchor.constraint(equalToConstant: 60),
            sendButton!.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20)
        ])
    }
    
    func analyzeImage() {
        let vc = AnalyzeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
