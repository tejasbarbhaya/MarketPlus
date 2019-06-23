//
//  ScanDetailsScreen.swift
//  MarketPlusDemo
//
//  Created by Tejash on 22/06/19.
//  Copyright © 2019 Tejas. All rights reserved.
//

import Foundation

import UIKit

class ScanDetailsScreen : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblScanTagName: UILabel!
    @IBOutlet weak var lblScanName: UILabel!
    
    var selectedScanObject : SampleScan!
    let text  = "Please agree for Terms & Conditions."
    
    var arrayLableSelection = [labelSelection]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tblView.delegate = self
        tblView.dataSource = self
        
        lblScanName.text = self.selectedScanObject.name
        lblScanTagName.text = self.selectedScanObject.tag
        
        if self.selectedScanObject.color == "red" {
            lblScanTagName.textColor = UIColor.red
        }else if self.selectedScanObject.color == "green" {
            lblScanTagName.textColor = UIColor.green
        }
        
        
        /*lblScanName.text = text
        self.lblScanName.textColor =  UIColor.white
        
        lblScanName.isUserInteractionEnabled = true
        lblScanName.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))*/
        
        
     }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        
        /*let termsRange = (text as NSString).range(of: "Terms & Conditions")
        // comment for now
        //let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: lblScanName, inRange: termsRange) {
            print("Tapped terms")
        } else if gesture.didTapAttributedTextInLabel(label: lblScanName, inRange: termsRange) {
            print("Tapped privacy")
        } else {
            print("Tapped none")
        }*/
        
        /*var position = gesture.location(in: self.tblView)
        guard let index = self.tblView.indexPathForRow(at: position) else {
            print("Error label not in tableView")
            return
        }
        
        let cell = self.tblView.cellForRow(at: index) as! ScanDetailsCell
        for obj in cell.arrayLblSelectionObject {
            print(obj.key)
            
            let lblText = cell.lblCriteriaName.text!
            let termsRange = (lblText as NSString).range(of: "(2.0)")
            /*if gesture.didTapAttributedTextInLabel(label: cell.lblCriteriaName, inRange: termsRange) {
                print("Tapped :",obj.replaceString)
            } else {
                print("Tapped none")
            }*/
            //var rect : CGRect  = cell.lblCriteriaName.boundingRect(forCharacterRange: termsRange)!
        }*/
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedScanObject.criteria.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scandetailcellId", for: indexPath) as! ScanDetailsCell
        
        let criteriaObject = self.selectedScanObject.criteria[indexPath.row]
        
        var orignalText: String = criteriaObject.text
        
        let finalText = orignalText.hashtags()
        //print(finalText)
        
        var arrayReplacedValues:[String] = [String]()
        arrayReplacedValues.removeAll()
        
        arrayLableSelection = [labelSelection]()
        
        if(finalText.count == criteriaObject.variable.count) {
            for obj in finalText {
                
                let lblSelection = labelSelection()
                
                for objC in criteriaObject.variable {
                    if obj == objC.keyValue {
                        var text = ""
                        if objC.varKeyName.type == "value" {
                            text = "(\(objC.varKeyName.values1[0]))"
                            orignalText = orignalText.replacingOccurrences(of:obj, with: text)
                            
                            lblSelection.key = objC.keyValue
                            lblSelection.values = objC.varKeyName.values1
                            lblSelection.type = objC.varKeyName.type
                            lblSelection.replaceString = text
                            
                            let range = (orignalText as NSString).range(of: text)
                            lblSelection.range = range
                            
                        }else {
                            text = "(\(objC.varKeyName.defaultValue!))"
                             orignalText = orignalText.replacingOccurrences(of:obj, with:text)
                            
                            lblSelection.key = objC.keyValue
                            lblSelection.defaultValue = objC.varKeyName.defaultValue
                            lblSelection.studyType = objC.varKeyName.studyType
                            lblSelection.parameterName = objC.varKeyName.parameterName
                            lblSelection.type = objC.varKeyName.type
                            lblSelection.replaceString = text
                            
                            let range = (orignalText as NSString).range(of: text)
                            lblSelection.range = range
                        }
                        arrayReplacedValues.append(text)
                        
                        arrayLableSelection.append(lblSelection);
                        
                        
                       break;
                    }
                }
            }
        }
        
        //print(orignalText)
        
        cell.lblCriteriaName.text = orignalText
        cell.lblCriteriaName.changeTextColor(fullText: orignalText, changeText: arrayReplacedValues)
        cell.arrayLblSelectionObject = arrayLableSelection
        
        //cell.lblCriteriaName.isUserInteractionEnabled = true
        //cell.lblCriteriaName.tag = indexPath.row
        //cell.lblCriteriaName.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        
        if criteriaObject.variable.count == 0 {
            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.isUserInteractionEnabled = false
        }else{
            cell.isUserInteractionEnabled = true
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        
        if (self.selectedScanObject.criteria.count - 1) == indexPath.row {
            cell.lblAND.isHidden = true
        }
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let criteriaObject = self.selectedScanObject.criteria[indexPath.row]
        //print("The row clicked is :\(criteriaObject.text!)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVariableList"{
            if let indexPath = self.tblView.indexPathForSelectedRow {
                let vc = segue.destination as! VariableListScreen
                //vc.selectedCriteriaObject = self.selectedScanObject.criteria[indexPath.row]
                let cell = self.tblView.cellForRow(at: indexPath) as! ScanDetailsCell
                
                if cell.arrayLblSelectionObject.count > 0 {
                    vc.selectedlabelSelection = cell.arrayLblSelectionObject[0] 
                }
            }
        }
    }
    
    

}

//MARK: Extensions 

extension String
{
    func hashtags() -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: "\\$\\d+", options: .caseInsensitive)
        {
            let string = self as NSString
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: "", with: "").lowercased()
            }
        }
        return []
    }
}

extension UILabel {
    func changeTextColor (fullText : String , changeText : [String] ) {
        let strNumber: NSString = fullText as NSString
        let attribute = NSMutableAttributedString.init(string: fullText)
        
        for i in 0..<changeText.count {
            let range = (strNumber).range(of: changeText[i])
            //print(range.location)
            attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 89.0/255.0, green: 132.0/255.0, blue: 188.0/255.0, alpha: 1.0) , range: range)
        }
        
        
        self.attributedText = attribute
    }
}

extension UILabel {
    func boundingRect(forCharacterRange range: NSRange) -> CGRect? {
        
        guard let attributedText = attributedText else { return nil }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        
        layoutManager.addTextContainer(textContainer)
        
        var glyphRange = NSRange()
        
        // Convert the range for glyphs.
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}



//MARK: - ScanDetailsCell

class ScanDetailsCell : UITableViewCell {
    
    @IBOutlet weak var lblAND: UILabel!
    @IBOutlet weak var lblCriteriaName: UILabel!
    
    var arrayLblSelectionObject:[labelSelection]!
}
//MARK: Model Object
class labelSelection : NSObject {
    var key : String!
    var type : String!
    var values : [Double]!
    var defaultValue:Int!
    var studyType:String!
    var parameterName:String!
    
    var replaceString:String!
    var range : NSRange!
}
