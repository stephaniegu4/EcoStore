//
//  UserVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit
import AVKit

class UserVC: CommonViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // starting up the camera
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)
        captureSession.addInput(input)
        
        captureSession.startRunning()
    }
}
