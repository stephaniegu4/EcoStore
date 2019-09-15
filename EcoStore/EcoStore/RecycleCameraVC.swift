import UIKit
import AVKit
import Vision

class RecycleCameraVC: CommonViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    //MARK:- Variables

    private let modalView = UIView()
    
    private let cancelIcon = UIImage(named:"cancel-icon")
    private let cancelButton = UIButton(type: .custom)
    
//    private let captureButton = UIButton()
    
    let pointsView = UIView()
    private let pointsReqLabel = UILabel()
    
    private var added = false;
    private var alertActive = false;
    // private var shouldPredict =  false;
    
    private var captureSession = AVCaptureSession();
    
    //MARK:- Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        modalView.backgroundColor = .black
        
        cancelButton.setImage(cancelIcon, for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
//        captureButton.setTitle("Hold To Capture", for: .normal)
//        captureButton.addTarget(self, action: #selector(StartRecording), for: .touchUpInside)
        
        modalView.addSubview(cancelButton)
        modalView.addSubview(pointsView)
        view.addSubview(modalView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        modalView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 40, height: view.frame.height * (4 / 5))
        modalView.center = view.center
        modalView.layer.cornerRadius = 20
        
        modalView.layer.masksToBounds = false
        modalView.layer.shadowColor = UIColor.black.cgColor
        modalView.layer.shadowRadius = 10
        modalView.layer.shadowOpacity = 0.5
        modalView.layer.shadowOffset = .zero
        
        cancelButton.frame = CGRect(x: modalView.frame.width - 40, y: 10, width: 30, height: 30)
        // captureButton.frame = CGRect(x: modalView.frame.width - 100, y: 0, width: 90, height: 30)

        cameraAction()
    }
    
//    @objc func StartRecording(){
//
//    }
    
    
    //MARK:- Control Actions
    func cameraAction() {
        // starting up the camera
        captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = modalView.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //        print("Camera was able to capture a frame", Date())
        
        if (!alertActive) {
            guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            guard let model = try? VNCoreMLModel(for: trashRecognition().model) else { return }
            let request = VNCoreMLRequest(model: model)
            { (finishedReq, err) in
                
                guard let results = finishedReq.results as?
                    [VNClassificationObservation] else { return }
                
                guard let firstObservation = results.first else { return }
                
                if (firstObservation.confidence > 0.9 && !self.added && !self.alertActive) {
                    if (firstObservation.identifier == "trash"){
                        let alert = UIAlertController(title: "Sorry :(", message: "This is trash. Please try again with something recyclable!",
                                                      preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Go Back", style: UIAlertActionStyle.default, handler: {
                            (action) in alert.dismiss(animated: true, completion: nil)
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.alertActive = true;
                        self.createAlert(title: "Success!", message: "Your item has been identified as: " + firstObservation.identifier
                            + " with a confidence of " + firstObservation.confidence.description + ". Is this correct?")
                    }
                }
                print(firstObservation.identifier, firstObservation.confidence)
            }
            
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {
            (action) in self.handleSuccessfulAdd(action: action)
        }))
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: {
            (action) in alert.dismiss(animated: true, completion: nil)
            self.alertActive = false;
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleSuccessfulAdd(action: UIAlertAction){
        captureSession.stopRunning();
        
        self.alertActive = false;
        self.added = true
        
        // Make API call to increment user's recycle number.
        
        let alert = UIAlertController(title: "Thanks for recycling!", message: "Your new count is __. Woohoo! Way to go!",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: {
            (action) in alert.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
