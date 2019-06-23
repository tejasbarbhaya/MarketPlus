//
//   ScanListScreen.swift
//  MarketPlusDemo
//
//  Created by Tejash on 21/06/19.
//  Copyright © 2019 Tejas. All rights reserved.
//

import Foundation
import UIKit

class ScanListScreen: UITableViewController  {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var finalScanArray:[SampleScan]! = [SampleScan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        NetworkCall.createNetworkClassObject().networkCall(completion: { respnse,error in
            
            self.activityIndicator.stopAnimating()
            
            if error != nil {
                print("error in fetchingData : ScanListScreen:: viewDidLoad()", errno)
            }else{
                
                self.finalScanArray.removeAll()
                
                let arrayValue = respnse as! [[String : Any]]
                
                
                for obj in arrayValue {
                    let scanClass = SampleScan(fromDictionary: obj)
                    self.finalScanArray.append(scanClass)
                }
                
                //print(self.finalScanArray)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.finalScanArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scancellID", for: indexPath) as! ScanListCell
        
        let scanObject = self.finalScanArray[indexPath.row] 
        
        cell.lbl_CategoryName.text = scanObject.name
        cell.lbl_CategoryTag.text = scanObject.tag
        
        if scanObject.color == "red" {
            cell.lbl_CategoryTag.textColor = UIColor.red
        }else if scanObject.color == "green" {
            cell.lbl_CategoryTag.textColor = UIColor.green
        }
        
        return cell;
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let scanObject = self.finalScanArray[indexPath.row]
        //print("The row clicked is :\(scanObject.name!)")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScanDetails"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let vc = segue.destination as! ScanDetailsScreen
                vc.selectedScanObject = self.finalScanArray[indexPath.row]
            }
        }
    }
}

// MARK: ScanListCell Class Defination

class ScanListCell : UITableViewCell {
    @IBOutlet weak var lbl_CategoryTag: UILabel!
    @IBOutlet weak var lbl_CategoryName: UILabel!
}

//


