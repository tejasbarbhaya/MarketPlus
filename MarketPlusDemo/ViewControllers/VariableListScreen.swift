//
//  VariableListScreen.swift
//  MarketPlusDemo
//
//  Created by Tejash on 22/06/19.
//  Copyright © 2019 Tejas. All rights reserved.
//

import Foundation

import UIKit

class VariableListScreen: UITableViewController {
    
    var selectedlabelSelection : labelSelection!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        if selectedlabelSelection.type == "value" {
            self.selectedlabelSelection.values.sort()
            return self.selectedlabelSelection.values.count
        }else {
            return 1;
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellValue : UITableViewCell!
        
        if selectedlabelSelection.type == "value" {
            let cellValueTemp = tableView.dequeueReusableCell(withIdentifier: "valueCellId", for: indexPath) as! VariableValueCell
            cellValueTemp.lblValue.text = "\(Int(self.selectedlabelSelection.values[indexPath.row]))"
            
            cellValue = cellValueTemp
        }else {
            let cellValueTemp = tableView.dequeueReusableCell(withIdentifier: "variableindicatorcellId", for: indexPath) as! VariableIndicatorCell
            
            cellValueTemp.lblVariableStudyType.text = self.selectedlabelSelection.studyType
            cellValueTemp.lblVariableParameterName.text = self.selectedlabelSelection.parameterName
            cellValueTemp.txtVariableDefaultValue.text = "\(self.selectedlabelSelection.defaultValue!)"
            
            cellValue = cellValueTemp
        }
        
        
        cellValue.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        
        return cellValue;
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedlabelSelection.type == "value" {
            return 50.0
        }else {
            return 100.0
        }
        
    }
}


class VariableValueCell: UITableViewCell{
    
    @IBOutlet weak var lblValue: UILabel!
}

class VariableIndicatorCell: UITableViewCell {
    @IBOutlet weak var lblVariableStudyType: UILabel!
    
    @IBOutlet weak var txtVariableDefaultValue: UITextField!
    @IBOutlet weak var lblVariableParameterName: UILabel!
}
