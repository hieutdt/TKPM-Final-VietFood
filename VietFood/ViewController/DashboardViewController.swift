//
//  ViewController.swift
//  VietFood
//
//  Created by HieuTDT on 8/30/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    /// Outlets
    private var imageCarousel = ImageCarousel()
    private var dimLayer = UIView()
    
    private var bottomView = UIView()
    private var separatorLine = UIView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var nextButton = UIButton()

    private var frameStep = 1
    private var titleLabelTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "VietFood"
        self.titleLabel.textColor = .primary
        self.titleLabel.font = UIFont(name: "Verdana", size: 20)
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.titleView = self.titleLabel
        
        // Init views
        imageCarousel.type = .remoteImage
        imageCarousel.urlData = [
            "https://mykitchies.files.wordpress.com/2018/10/2018-10-14-12-19-441565186905.jpg?w=1080",
            "https://vcdn-dulich.vnecdn.net/2018/10/29/500px-Phohaitrieu-6059-1540791323.jpg",
            "https://images.foody.vn/res/g104/1030781/prof/s640x400/foody-upload-api-foody-mobile-foody-upload-api-foo-200619091742.jpg",
            "https://cdn.cet.edu.vn/wp-content/uploads/2019/11/banh-xeo-mien-bac.jpg"
        ]
        
        self.view.backgroundColor = .white
        bottomView.backgroundColor = .white
        dimLayer.backgroundColor = UIColor.black
        
        // Add all subviews
        self.view.addSubview(imageCarousel)
        self.view.addSubview(dimLayer)
        self.view.addSubview(bottomView)
        
        bottomView.addSubview(descriptionLabel)
        bottomView.addSubview(nextButton)
        bottomView.addSubview(separatorLine)
        
        imageCarousel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        dimLayer.translatesAutoresizingMaskIntoConstraints = false
        
        // Layouts
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageCarousel.topAnchor.constraint(equalTo: guide.topAnchor),
            imageCarousel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageCarousel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageCarousel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dimLayer.topAnchor.constraint(equalTo: guide.topAnchor),
            dimLayer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            dimLayer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            dimLayer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        initBottomView()

        imageCarousel.reloadData()
        
        // Set up for animate
        self.bottomView.transform = CGAffineTransform(translationX: 0, y: 230)
        self.dimLayer.alpha = 0
        self.nextButton.transform = CGAffineTransform(translationX: 0, y: 230)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.animate(withDuration: 0.3) {
                self.bottomView.transform = .identity
                self.dimLayer.alpha = 0.4
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.9) {
            UIView.animate(withDuration: 0.3) {
                self.nextButton.transform = .identity
            }
        }
    }
    
    private func initBottomView() {
        // Create frame of bottomView
        bottomView.layer.shadowRadius = 20
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowOpacity = 0.7
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        // Layout
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            separatorLine.widthAnchor.constraint(equalToConstant: 80),
            separatorLine.heightAnchor.constraint(equalToConstant: 5),
            separatorLine.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // Init UI for subviews
        descriptionLabel.text = "Khám phá thế giới Ẩm thực Việt qua camera của bạn!"
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .center
        
        nextButton.backgroundColor = .primary
        nextButton.setBackgroundColor(color: .primaryHighlight, forState: .highlighted)
        nextButton.setTitle("KHÁM PHÁ NGAY", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self, action: #selector(openCameraViewController), for: .touchUpInside)
        
        separatorLine.layer.cornerRadius = 2.5
        separatorLine.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    @objc func openCameraViewController() {
        let vc = CameraViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

