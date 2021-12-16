//
//  DetailsViewController.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 22/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var buttonLabel: UIButton!
    
    
    var codeData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.dataDetectorTypes = .all
        buttonLabel.setTitle("Copy To ClipBoard", for: .normal)
        buttonLabel.layer.cornerRadius = 10
        buttonLabel.clipsToBounds = true
        self.navigationItem.hidesBackButton = true
        updateUI(for: codeData ?? "empty")
    }
    
    func updateUI(for textValue: String){
        textView.text = textValue
        textView.layer.cornerRadius = textView.frame.height / 4
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = textView.text
        buttonLabel.setTitle("Text Copied", for: .normal)
        buttonLabel.backgroundColor = UIColor.clear
        buttonLabel.layer.borderWidth = 2
        buttonLabel.layer.borderColor = #colorLiteral(red: 0.8509480953, green: 0.956777513, blue: 0.9411808848, alpha: 1)
        
    }
    

}
