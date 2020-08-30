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
    
    let session = AVCaptureSession()
    var previewLayer: CALayer!
    
    var captureDevice: AVCaptureDevice!
    
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
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        
        self.session.startRunning()
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value: kCVPixelFormatType_32BGRA)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if self.session.canAddOutput(dataOutput) {
            self.session.addOutput(dataOutput)
        }
        
        session.commitConfiguration()
    }
}
