
import UIKit
import CoreImage
import AVFoundation
import ImageIO

class FaceViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {

    //MARK: Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var optionsView: UIView!
    
    //MARK:  Variables
     var onlyFireNotificatonOnStatusChange : Bool = true
    
     let notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter()
    private(set) var faceDetected : Bool?
    private(set) var faceBounds : CGRect?
    private(set) var hasSmile : Bool?
    private(set) var isBlinking : Bool?
    private(set) var isWinking : Bool?
    
    //MARK: Notifications
    private let faceDetectorNoFaceDetectedNotification = NSNotification(name: "faceDetectorNoFaceDetectedNotification", object: nil)
    private let faceDetectorFaceDetectedNotification = NSNotification(name: "faceDetectorFaceDetectedNotification", object: nil)
    private let faceDetectorSmilingNotification = NSNotification(name: "faceDetectorHasSmileNotification", object: nil)
    private let faceDetectorNotSmilingNotification = NSNotification(name: "faceDetectorHasNoSmileNotification", object: nil)
    private let faceDetectorWinkingNotification = NSNotification(name: "faceDetectorWinkingNotification", object: nil)
    private let faceDetectorNotWinkingNotification = NSNotification(name: "faceDetectorNotWinkingNotification", object: nil)
    
    
    //MARK:  Set of Variables for camera
    private var faceDetector : CIDetector?
    private var videoDataOutput : AVCaptureVideoDataOutput?
    private var videoDataOutputQueue : dispatch_queue_t?
    private var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    private var captureSession : AVCaptureSession = AVCaptureSession()
    private var currentOrientation : Int?
    
     var previewLayer = AVCaptureVideoPreviewLayer()

     var faceDetectorOptions : [String : AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("smile Please!",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        self.captureSetup(AVCaptureDevicePosition.Front)

         faceDetectorOptions = [CIDetectorAccuracy : CIDetectorAccuracyHigh]

        self.faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: faceDetectorOptions)

        onlyFireNotificatonOnStatusChange = false
        
        deviceOrientationChecks()
        
        beginFaceDetection()


        self.view.bringSubviewToFront(optionsView)
        
        NSNotificationCenter.defaultCenter().addObserverForName("faceDetectorFaceDetectedNotification", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { notification in
            
            self.messageLabel.text = "Please 😊 or 😉 to help me increase the count."
            
            if ((self.hasSmile == true && self.isWinking == true)) {
                self.messageLabel.text = "Thanks. 😊"
                self.endFaceDetection()
                
            } else if ((self.isWinking == true && self.hasSmile == false)) {
                self.messageLabel.text = "Thanks. 😊"
                self.endFaceDetection()
                
            } else if ((self.hasSmile == true && self.isWinking == false)) {
                self.messageLabel.text = "Thanks. 😊"
                self.endFaceDetection()
                
            } else {
                self.messageLabel.text = "😊 Please"
            }
        })
        
        NSNotificationCenter.defaultCenter().addObserverForName("faceDetectorNoFaceDetectedNotification", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { notification in
            
           self.messageLabel.text = "Don't hide your face from Me. 🤓"
        })
        

    }

    func beginFaceDetection() {
        self.captureSession.startRunning()
    }
    
    func endFaceDetection() {
        self.messageLabel.text = "Thanks. 😊"
        self.captureSession.stopRunning()
    }
    

    
     func captureSetup (position : AVCaptureDevicePosition) {
        var captureError : NSError?
        var captureDevice : AVCaptureDevice!
        
        for testedDevice in AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo){
            if (testedDevice.position == position) {
                captureDevice = testedDevice as! AVCaptureDevice
            }
        }
        
        if (captureDevice == nil) {
            captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        }
        
        var deviceInput : AVCaptureDeviceInput?
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error as NSError {
            captureError = error
            deviceInput = nil
        }
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        if (captureError == nil) {
            if (captureSession.canAddInput(deviceInput)) {
                captureSession.addInput(deviceInput)
            }
            
            self.videoDataOutput = AVCaptureVideoDataOutput()
            self.videoDataOutput!.videoSettings = [kCVPixelBufferPixelFormatTypeKey: Int(kCVPixelFormatType_32BGRA)]
            self.videoDataOutput!.alwaysDiscardsLateVideoFrames = true
            self.videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL)
            self.videoDataOutput!.setSampleBufferDelegate(self, queue: self.videoDataOutputQueue!)
            
            if (captureSession.canAddOutput(self.videoDataOutput)) {
                captureSession.addOutput(self.videoDataOutput)
            }
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = UIScreen.mainScreen().bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(previewLayer)
    }
    
     var options : [String : AnyObject]?
   
    // Handling Changes
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let opaqueBuffer = Unmanaged<CVImageBuffer>.passUnretained(imageBuffer!).toOpaque()
        let pixelBuffer = Unmanaged<CVPixelBuffer>.fromOpaque(opaqueBuffer).takeUnretainedValue()
        let sourceImage = CIImage(CVPixelBuffer: pixelBuffer, options: nil)
        options = [CIDetectorSmile : true, CIDetectorEyeBlink: true, CIDetectorImageOrientation : 6]
        
        let features = self.faceDetector!.featuresInImage(sourceImage, options: options)
        
        if (features.count != 0) {
            
            if (onlyFireNotificatonOnStatusChange == true) {
                if (self.faceDetected == false) {
                    notificationCenter.postNotification(faceDetectorFaceDetectedNotification)
                }
            } else {
                notificationCenter.postNotification(faceDetectorFaceDetectedNotification)
            }
            
            self.faceDetected = true
            
            for feature in features as! [CIFaceFeature] {
                faceBounds = feature.bounds
                
                if (feature.hasSmile) {
                    if (onlyFireNotificatonOnStatusChange == true) {
                        if (self.hasSmile == false) {
                            notificationCenter.postNotification(faceDetectorSmilingNotification)
                        }
                    } else {
                        notificationCenter.postNotification(faceDetectorSmilingNotification)
                    }
                    
                    hasSmile = feature.hasSmile
                    
                } else {
                    if (onlyFireNotificatonOnStatusChange == true) {
                        if (self.hasSmile == true) {
                            notificationCenter.postNotification(faceDetectorNotSmilingNotification)
                        }
                    } else {
                        notificationCenter.postNotification(faceDetectorNotSmilingNotification)
                    }
                    
                    hasSmile = feature.hasSmile
                }
                
                if (feature.leftEyeClosed || feature.rightEyeClosed) {
                    if (onlyFireNotificatonOnStatusChange == true) {
                        if (self.isWinking == false) {
                            notificationCenter.postNotification(faceDetectorWinkingNotification)
                        }
                    } else {
                        notificationCenter.postNotification(faceDetectorWinkingNotification)
                    }
                    
                    isWinking = true
                    
                } else {
                    
                    if (onlyFireNotificatonOnStatusChange == true) {
                        
                        if (self.isWinking == true) {
                            notificationCenter.postNotification(faceDetectorNotWinkingNotification)
                        }
                        
                    } else {
                        notificationCenter.postNotification(faceDetectorNotWinkingNotification)
                    }
                    
                    isBlinking = false
                    isWinking = false
                }
            }
        } else {
            if (onlyFireNotificatonOnStatusChange == true) {
                if (self.faceDetected == true) {
                    notificationCenter.postNotification(faceDetectorNoFaceDetectedNotification)
                }
            } else {
                notificationCenter.postNotification(faceDetectorNoFaceDetectedNotification)
            }
            
            self.faceDetected = false
        }
    }
    
    // MARK: Orientation Checks
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        deviceOrientationChecks()
    }
    
    func deviceOrientationChecks(){
        switch UIDevice.currentDevice().orientation{
            
        case .LandscapeLeft, .LandscapeRight:
            endFaceDetection()
            self.captureSession.stopRunning()
            previewLayer.removeFromSuperlayer()
            optionsView.hidden = true
            checkLabel.text = "Please change the device orientation."
            
        case .Portrait,.PortraitUpsideDown:
            previewLayer.frame = UIScreen.mainScreen().bounds
            beginFaceDetection()
            self.captureSession.startRunning()
            optionsView.hidden = false
            self.view.layer.addSublayer(previewLayer)
            self.view.bringSubviewToFront(optionsView)
        default:
            break
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
}
