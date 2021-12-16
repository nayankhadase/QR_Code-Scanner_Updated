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
    var indexForCopy: Int?
    
    var localHistory = LocalHistory()
    
    var historyData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        updateArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateArray()
    }
    
    @IBAction func copyBtnPressed(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = historyData[sender.tag]
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func updateArray(){
        if localHistory.getData(for: K.userDefaultName) != nil{
            historyData = localHistory.getData(for: K.userDefaultName)!
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
        indexForCopy = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: K.historyCellIdentifier, for: indexPath) as! HistoryTableViewCell
        cell.cellLabel.text = historyData[indexForCopy!]
        cell.copyBtnLabel.tag = indexForCopy!
        cell.copyBtnLabel.setTitleColor(UIColor.white, for: .normal)
        cell.copyBtnLabel.backgroundColor = UIColor.blue
        return cell
    }
    
    
    // delete table cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            historyData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            localHistory.setData(for: historyData)
            updateArray()
            tableView.endUpdates()
        }
    }

    
}

