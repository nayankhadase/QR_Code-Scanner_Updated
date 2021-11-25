//
//  ImageScannerViewController.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 22/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit

class ImageScannerViewController: UIViewController {

    @IBOutlet weak var pickBtnLabel: UIButton!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    var qrData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickBtnLabel.layer.cornerRadius = 10
        pickBtnLabel.clipsToBounds = true
        imageHeightConstraint.constant = imageView.frame.width
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    
    // alert box:
    func getAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
            print(UIAlertAction.Style.self)
        }
        alert.addAction(action)
        DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
        }
    
    }
}

//MARK: - UIImage Picker delegate
extension ImageScannerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // get selected image and convert it into CIImage (we can process CIImage)
        if let img = info[.originalImage] as? UIImage, let ciImage = CIImage.init(image: img){
            imageView.image = img // set image to image view
            imageHeightConstraint.constant = imageView.frame.width  // set height of image equal to width
            let context = CIContext()
            let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            
            // create detector which is An image processor that identifies notable features like face or barcode
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if let features = detector?.features(in: ciImage) as? [CIQRCodeFeature]{
                print("count: \(features.count)")
                for feature in features{
                    qrData = feature.messageString
                }
                if qrData != nil {
                    // perform segue
                    performSegue(withIdentifier: "ImageToDetails", sender: self)
                    picker.dismiss(animated: true, completion: nil)
                    qrData = nil
                    imageView.image = UIImage()
                }else{
                    // show alert
                    getAlert(title: "Alert", message: "Your image is not a QR Code or doesn't have data in it")
                    print("your image doesnt have data")
                    picker.dismiss(animated: true, completion: nil)
                }
                
            }else{
                print("no features")
                return
            }
        }else{
            print("image not covertible")
            return
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    // prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC2 = segue.destination as! DetailsViewController
        destinationVC2.codeData = qrData
        
    }
    
    // if user press cancel button
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancle")
         picker.dismiss(animated: true, completion: nil)
        
    }
    
}

