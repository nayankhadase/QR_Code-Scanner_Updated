//
//  ViewController.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 22/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn1Label: UIButton!
    @IBOutlet weak var btn2Label: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1Label.layer.cornerRadius = 10
        btn2Label.layer.cornerRadius = 10
        btn2Label.clipsToBounds = true
        btn1Label.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    


}
