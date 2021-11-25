//
//  DetailsViewController.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 22/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var buttonLabel: UIButton!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    var codeData: String?{
        didSet{
            DispatchQueue.main.async {
                self.dataLabel.text = self.codeData
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLabel.setTitle("Copy To ClipBoard", for: .normal)
        buttonLabel.layer.cornerRadius = 10
        buttonLabel.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = dataLabel.text
        buttonLabel.setTitle("Text Copied", for: .normal)
        buttonLabel.backgroundColor = UIColor.clear
        buttonLabel.layer.borderWidth = 2
        buttonLabel.layer.borderColor = #colorLiteral(red: 0.8509480953, green: 0.956777513, blue: 0.9411808848, alpha: 1)
        
    }
    

}
