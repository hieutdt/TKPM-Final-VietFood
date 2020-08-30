//
//  ImageCarousel.swift
//  VietFood
//
//  Created by HieuTDT on 8/30/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit
import SDWebImage

enum ImageCarouselType {
    case localImage
    case remoteImage
}

// MARK: - ImageCarousell

class ImageCarousel: UIView {

    var type: ImageCarouselType = .localImage
    
    var data: [UIImage] = []
    var urlData: [String] = []
    
    var collectionView: UICollectionView?
    var currentIndex: Int =  0
    var isActivate = true {
        didSet {
            if isActivate {
                self.startAutoScroll()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.customInit()
    }
    
    private func customInit() {
        self.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true
        
        self.addSubview(collectionView!)
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        collectionView!.register(ImageCarouselCell.self,
                                forCellWithReuseIdentifier: ImageCarouselCell.reuseIdentifier)
        
        if self.isActivate {
            self.startAutoScroll()
        }
    }
    
    private func startAutoScroll() {
        // Create background thread to autoscroll
        DispatchQueue.global(qos: .background).async {
            while self.isActivate {
                sleep(2)
                DispatchQueue.main.async {
                    self.collectionView?.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0),
                                                 at: .left,
                                                 animated: true)
                    
                    self.currentIndex += 1
                    if self.type == .localImage && self.currentIndex >= self.data.count {
                        self.currentIndex = 0
                    }
                    if self.type == .remoteImage && self.currentIndex >= self.urlData.count {
                        self.currentIndex = 0
                    }
                }
            }
        }
    }
    
    public func reloadData() {
        self.collectionView!.reloadData()
    }
    
    public func relayoutSubviews() {
        self.collectionView!.layoutSubviews()
    }
}

extension ImageCarousel: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.type == .localImage ? data.count : urlData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.reuseIdentifier,
                                                            for: indexPath) as? ImageCarouselCell
        
        if cell == nil {
            cell = ImageCarouselCell()
        }
        
        if self.type == .localImage {
            cell?.setImageData(image: self.data[indexPath.item])
        } else {
            cell?.setImageData(url: self.urlData[indexPath.item])
        }
        
        return cell!
    }
}

extension ImageCarousel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
}

// MARK: - ImageCarouselCell

class ImageCarouselCell: UICollectionViewCell {

    private var imageView = UIImageView()

    override var reuseIdentifier: String? {
        get {
            "ImageCarouselCellReuseId"
        }
    }
    
    static public let reuseIdentifier = "ImageCarouselCellReuseId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.customInit()
    }
    
    private func customInit() {
        imageView.contentMode = .scaleToFill
        
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    public func setImageData(image: UIImage) {
        self.imageView.image = image
    }
    
    public func setImageData(url: String) {
        self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
    }
}
