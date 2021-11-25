//
//  ScannerViewController.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 22/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit
import AVFoundation



class ScannerViewController: UIViewController {

    
    @IBOutlet weak var scanAreaImage: UIImageView!
    var captureSession = AVCaptureSession()  // An object that manages capture activity
    var videoPreviewLayer: AVCaptureVideoPreviewLayer? // A Core Animation layer that can display video as it is being captured.
    var qrcodeFrameView = UIView() //An object that manages the content for a rectangular area on the screen.
    var qrCodeData: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanAreaImage.layer.borderWidth = 2
        scanAreaImage.layer.borderColor = #colorLiteral(red: 0.944797092, green: 0.9084743924, blue: 0.8337131076, alpha: 1)
        scanAreaImage.layer.cornerRadius = 5
        scanAreaImage.clipsToBounds = true
        getCameraScanData()
        
    }
    func getCameraScanData(){
        // get the back facing camera to capture media
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("didn't capture")
            return
        }
        
        do {
            // create input from capture device (A capture input that provides media from a capture device)
            let input =  try AVCaptureDeviceInput(device: captureDevice)
            
            // set input device on capture session
            captureSession.addInput(input)
            
            //initialize the AVCapture metadataOutput object (A capture output for processing timed metadata produced by a capture session.)
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetaDataOutput)
            
            // Sets the delegate and dispatch queue to use handle callbacks.
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // which metadata object we want to process
            captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // initialie the vodeoPreview layer and add it a sublayer of view's layer
            //(AVCaptureVideoPreviewLayer is a subclass of CALayer that you use to display video as it is being captured by an input device.)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            //video Gravity is use to handle AVCaptureVideoPreviewLayer property
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // start video capture
            //(This method is used to start the flow of data from the inputs to the outputs connected to the AVCaptureSession instance that is the receiver.)
            captureSession.startRunning()
            
            
            // initialize the qrcode view
            qrcodeFrameView = UIView()
            if qrcodeFrameView == qrcodeFrameView{
                qrcodeFrameView.layer.borderColor = UIColor.yellow.cgColor
                qrcodeFrameView.layer.borderWidth = 2
                view.addSubview(qrcodeFrameView)
                view.bringSubviewToFront(qrcodeFrameView)
            }
            
        } catch {
            print("error while setting input device")
            return
        }
    }
}

//MARK: - metadata
//Methods for receiving metadata produced by a metadata capture output.
extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr{
            //let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            if metadataObj.stringValue != nil{
                print(metadataObj.stringValue!)
                qrCodeData = metadataObj.stringValue!
                performSegue(withIdentifier: "ViewDetails", sender: self)
                qrCodeData = nil
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        destinationVC.codeData = qrCodeData
    }
    
}
