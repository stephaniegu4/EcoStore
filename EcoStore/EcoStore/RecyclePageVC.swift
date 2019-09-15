//
//  RecyclePageVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit
import AVKit
import Vision

class RecyclePageVC: CommonViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // MARK:- Variables
    private var topView = UIView()
    
    private var recycleView = UIImageView()
    private var recycleIcon = UIImage(named:"recycle-icon")
    
    private var descriptionText = UILabel()
    
    private var cameraButton = UIButton(type: .custom)
    private var cameraIcon = UIImage(named:"camera2-icon")
    
    private var semiCircleView = UIView()
    
    private var bottomView = UIView()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(topView)
        
        recycleView.image = recycleIcon
        topView.addSubview(recycleView)
        
        descriptionText.text = "Take a picture of your recyclable item!"
        descriptionText.font = UIFont(name: "AvenirNext-Bold", size: 20)
        descriptionText.textAlignment = .left
        descriptionText.textColor = .darkGray
        descriptionText.numberOfLines = 0
        descriptionText.lineBreakMode = .byWordWrapping
        topView.addSubview(descriptionText)
        
        semiCircleView.backgroundColor = UIColor.fromRGB(88, 185, 121)
        view.addSubview(semiCircleView)
        
        bottomView.backgroundColor = UIColor.fromRGB(88, 185, 121)
        view.addSubview(bottomView)
        
        cameraButton.setImage(cameraIcon, for: .normal)
        cameraButton.addTarget(self, action: #selector(cameraAction), for: .touchUpInside)
        view.addSubview(cameraButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recycleView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        descriptionText.frame = CGRect(x: recycleView.frame.maxX + 10, y: 0, width: view.frame.width - recycleView.frame.maxX - 80, height: recycleView.frame.height)
        descriptionText.center.y = recycleView.center.y
        
        topView.frame = CGRect(x: 0, y: 150, width: recycleView.frame.width + descriptionText.frame.width + 10, height: recycleView.frame.height)
        topView.center.x = view.center.x
        
        semiCircleView.frame = CGRect(x: 0, y: view.frame.height / 2 - 50, width: view.frame.width + 50, height: 300)
        semiCircleView.layer.cornerRadius = semiCircleView.frame.width / 2
        semiCircleView.center.x = view.center.x
        
        bottomView.frame = CGRect(x: 0, y: semiCircleView.center.y, width: view.frame.width, height: view.frame.height - semiCircleView.center.y)
        
        cameraButton.frame = CGRect(x: 0, y: semiCircleView.frame.minY + 100, width: 225, height: 225)
        cameraButton.center.x = view.center.x
    }
    
    // MARK:- Control Actions
    @objc func cameraAction() {
        // starting up the camera
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        // accessing camera frame layer
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
//        let dataOutput = AVCapturePhotoOutput()
//        guard captureSession.canAddOutput(dataOutput) else { return }
//        captureSession.addOutput(dataOutput)
//        print(dataOutput)
//        captureSession.commitConfiguration()


    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        print("Camera was able to capture a frame", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: trashRecognition().model) else { return }
        let request = VNCoreMLRequest(model: model)
            { (finishedReq, err) in
                
            guard let results = finishedReq.results as?
                [VNClassificationObservation] else { return }
                
            guard let firstObservation = results.first else { return }
            
            if (firstObservation.confidence > 0.9) {
                self.createAlert(title: "Success!", message: firstObservation.identifier + " with a confidence of " + firstObservation.confidence.description)
            }
            print(firstObservation.identifier, firstObservation.confidence)
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])

    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            (action) in alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

