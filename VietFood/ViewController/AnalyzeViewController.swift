//
//  AnalyzeViewController.swift
//  VietFood
//
//  Created by Trần Đình Tôn Hiếu on 9/1/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

let serverUrl = "http://e476a63dd827.ngrok.io/"

class AnalyzeViewController: UIViewController {
    
    public var image: UIImage?
    
    var predicted: String = ""
    var score: Float = 0.0
    
    // UI
    var imageView = UIImageView()
    var predictedLabel = UILabel()
    var scoreLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .primary
        
        image = UIImage(named: "banhxeo")
        imageView.image = image
        predictedLabel.font = UIFont.systemFont(ofSize: 24)
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        
        /// Init UI
        self.view.addSubview(imageView)
        self.view.addSubview(predictedLabel)
        self.view.addSubview(scoreLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        predictedLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        NSLayoutConstraint.activate([
            predictedLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            predictedLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            predictedLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: predictedLabel.bottomAnchor, constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        /// Show loading
        self.showEmbeddedLoading(text: "Đang phân tích, bạn chờ xíu nhé!")
        
        /// Request
        let base64string = getBase64String(image: self.image!)
        self.requestPredict(base64: base64string)
    }
    
    func requestPredict(base64: String) {
        let url = URL(string: serverUrl)
        
        if url == nil {
            // Show error
            return
        }
        
        var headers = HTTPHeaders()
        headers = [
            "Content-Type" :"application/json",
            "Accept": "application/json"
        ]
        
        let params: [String : String] = [
            "img_encoded" : base64,
            "lang" : "custom",
            "type" : "classify"
        ]
        
        AF.request(serverUrl,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON { (response) in
                    
                    self.hideEmbeddedLoading()
                    
                    switch response.result {
                        
                    case .success(_):
                        let json = response.value as! NSDictionary
                        self.predicted = json.value(forKey: "predicted") as! String
                        self.score = json.value(forKey: "score") as! Float
                        self.updateResultUI()
                        
                        break
                        
                    case .failure(let error):
                        print(error)
                        break
                    }
        }
    }
    
    func getBase64String(image: UIImage) -> String {
        let imageData = image.pngData()
        let imageBase64String = imageData?.base64EncodedString()
        
        return imageBase64String ?? ""
    }
    
    func updateResultUI() {
        predictedLabel.text = "Kết quả dự đoán: \(self.predicted)"
        scoreLabel.text = "Độ chính xác: \(self.score)"
    }
}
