//
//  HistoryViewController.swift
//  QR_Code Scanner
//
//  Created by nayan.khadase on 29/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    
    var localHistory = LocalHistory()
    
    var historyData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if localHistory.getData(for: "ScanHistory").count > 0{
            historyData = localHistory.getData(for: "ScanHistory")
        }
        historyTableView.reloadData()
    }
    
}

//MARK: - table view data source and delegate
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.cellLabel.text = historyData[indexPath.row]
        return cell
    }
    
    
}
extension HistoryViewController: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("hello")
    }
}
