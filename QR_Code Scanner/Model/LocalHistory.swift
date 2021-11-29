//
//  LocalHistory.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 29/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import Foundation
struct LocalHistory {
    let defaults = UserDefaults.standard
    
    func setData(for arrayData: [String]){
        defaults.set(arrayData, forKey: "ScanHistory")
    }
    
    func getData(for key: String) -> [String]{
        return defaults.array(forKey: key) as! [String]
    }
    
}
