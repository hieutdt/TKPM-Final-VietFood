//
//  CameraViewController.swift
//  VietFood
//
//  Created by HieuTDT on 8/30/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    // UI
    var previewLayer: CALayer!
    var bottomView: UIView?
    var captureButton: UIButton?
    
    //
    let session = AVCaptureSession()
    var captureDevice: AVCaptureDevice!
    var takePhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareCamera()
    }

    func prepareCamera() {
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                  mediaType: .video,
                                                                  position: .back).devices
        captureDevice = availableDevices.first
        beginSession()
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: self.captureDevice)
            
            session.addInput(captureDeviceInput)
            
        } catch {
            print(error.localizedDescription)
        }
        
        /// Init UI Here
        self.createUI()
        
        self.session.startRunning()
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value: kCVPixelFormatType_32BGRA)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if self.session.canAddOutput(dataOutput) {
            self.session.addOutput(dataOutput)
        }
        
        session.commitConfiguration()
        
        let queue = DispatchQueue(label: "vietfood.CaptureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    func createUI() {
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = CGRect(x: view.layer.frame.origin.x,
                                         y: view.layer.frame.origin.y,
                                         width: view.layer.frame.width,
                                         height: view.layer.frame.height - 50)
        
        bottomView = UIView()
        captureButton = UIButton()
        
        self.view.addSubview(bottomView!)
        bottomView?.addSubview(captureButton!)
        
        bottomView?.translatesAutoresizingMaskIntoConstraints = false
        captureButton?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView!.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        bottomView?.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            captureButton!.centerXAnchor.constraint(equalTo: bottomView!.centerXAnchor),
            captureButton!.centerYAnchor.constraint(equalTo: bottomView!.centerYAnchor),
            captureButton!.heightAnchor.constraint(equalToConstant: 70),
            captureButton!.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        captureButton?.setImage(UIImage(named: "capture"), for: .normal)
        captureButton?.setImage(UIImage(named: "capture_tap"), for: .highlighted)
        captureButton?.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
    }
    
    @objc func captureImage() {
        self.takePhoto = true
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        if self.takePhoto {
            self.takePhoto = false
            
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer) {
                DispatchQueue.main.async {
                    let vc = PreviewImageViewController()
                    vc.image = image
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0,
                                   y: 0,
                                   width: CVPixelBufferGetWidth(pixelBuffer),
                                   height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        
        return nil
    }
}
