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
    private var nextButton: ActionButton?
    private var galleryButton: ActionButton?
    private var cameraButton: ActionButton?

    private var frameStep = 1
    private var titleLabelTopConstraint: NSLayoutConstraint?
    
    private let bottomViewHeight: CGFloat = 230
    private let actionButtonHeight: CGFloat = 80
    
    private var bottomViewHeightConstraint: NSLayoutConstraint?
    
    // Image picker
    private var imagePicker = UIImagePickerController()
    
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
        
        // Init all buttons
        nextButton = ActionButton(title: "KHÁM PHÁ NGAY",
                                    titleColor: .white,
                                    titleHighlightColor: .white,
                                    backgroundColor: .primary,
                                    highlightBackgroundColor: .primaryHighlight,
                                    action: {
                                        self.nextTapped()
        })
        
        galleryButton = ActionButton(title: "SỬ DỤNG THƯ VIỆN ẢNH",
                                     titleColor: .primary,
                                     titleHighlightColor: .primaryHighlight,
                                     backgroundColor: .white,
                                     highlightBackgroundColor: .primaryLight,
                                     action: {
                                        self.openGalleryTapped()
        })
        galleryButton?.layer.borderColor = UIColor.primary.cgColor
        galleryButton?.layer.borderWidth = 2
        galleryButton?.showShadow = false
        
        cameraButton = ActionButton(title: "SỬ DỤNG CAMERA",
                                    titleColor: .white,
                                    titleHighlightColor: .white,
                                    backgroundColor: .primary,
                                    highlightBackgroundColor: .primaryHighlight,
                                    action: {
                                        self.openCameraTapped()
        })
        cameraButton?.showShadow = false
        
        // Add all subviews
        self.view.addSubview(imageCarousel)
        self.view.addSubview(dimLayer)
        self.view.addSubview(bottomView)
        
        bottomView.addSubview(descriptionLabel)
        bottomView.addSubview(nextButton!)
        bottomView.addSubview(separatorLine)
        bottomView.addSubview(cameraButton!)
        bottomView.addSubview(galleryButton!)
        
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

        self.bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: bottomViewHeight)
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.bottomViewHeightConstraint!
        ])
        
        initBottomView()

        imageCarousel.reloadData()
        
        // Set up for animate
        self.bottomView.transform = CGAffineTransform(translationX: 0, y: bottomViewHeight)
        self.nextButton!.transform = CGAffineTransform(translationX: 0, y: bottomViewHeight)
        self.dimLayer.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.animate(withDuration: 0.3) {
                self.bottomView.transform = .identity
                self.dimLayer.alpha = 0.4
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            UIView.animate(withDuration: 0.3) {
                self.nextButton!.transform = .identity
            }
        }
    }
    
    private func initBottomView() {
        // Create frame of bottomView
        bottomView.dropShadow(shadowRadius: 20)
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        // Layout
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton!.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        cameraButton!.translatesAutoresizingMaskIntoConstraints = false
        galleryButton?.translatesAutoresizingMaskIntoConstraints = false
        
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
            nextButton!.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            nextButton!.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            nextButton!.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            nextButton!.heightAnchor.constraint(equalToConstant: actionButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            cameraButton!.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            cameraButton!.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            cameraButton!.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            cameraButton!.heightAnchor.constraint(equalToConstant: actionButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            galleryButton!.topAnchor.constraint(equalTo: cameraButton!.bottomAnchor, constant: 20),
            galleryButton!.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            galleryButton!.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            galleryButton!.heightAnchor.constraint(equalToConstant: actionButtonHeight)
        ])
        
        // Init UI for subviews
        descriptionLabel.text = "Khám phá thế giới Ẩm thực Việt qua camera của bạn!"
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .center
        
        separatorLine.layer.cornerRadius = 2.5
        separatorLine.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        cameraButton?.isHidden = true
        galleryButton?.isHidden = true
    }
    
    @objc func openCameraViewController() {
        let vc = CameraViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Actions
    
    private func nextTapped() {
        self.nextButton?.isHidden = true
        self.cameraButton?.isHidden = false
        self.galleryButton?.isHidden = false
        self.cameraButton?.transform = CGAffineTransform(translationX: 0, y: 300)
        self.galleryButton?.transform = CGAffineTransform(translationX: 0, y: 300)
        
        self.bottomViewHeightConstraint?.constant = 350
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutSubviews()
            self.cameraButton?.transform = .identity
            self.galleryButton?.transform = .identity
        }
        
    }
    
    private func openCameraTapped() {
        
    }
    
    private func openGalleryTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension DashboardViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage?
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        dismiss(animated: true, completion: {
            let vc = PreviewImageViewController()
            vc.image = newImage!
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}

