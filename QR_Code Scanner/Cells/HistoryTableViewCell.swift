//
//  HistoryTableViewCell.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 29/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
