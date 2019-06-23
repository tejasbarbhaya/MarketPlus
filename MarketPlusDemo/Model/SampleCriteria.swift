//
//  SampleCriteria.swift
//  Created on June 21, 2019

import Foundation


class SampleCriteria : NSObject, NSCoding{

    var text : String!
    var type : String!
    //var variable : SampleVariable!
    var variable : [SampleVariable]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        text = dictionary["text"] as? String
        type = dictionary["type"] as? String
        
        /*if let variableData = dictionary["variable"] as? [String:Any]{
            variable = SampleVariable(fromDictionary: variableData)
        }*/
        variable = [SampleVariable]()
        if let variableData = dictionary["variable"] as? [String:Any]{
            //variable = SampleVariable(fromDictionary: variableData)
            for keyValue in variableData.keys {
                //print("keyValues : ",keyValue)
                let localvariable = SampleVariable(fromDictionary: variableData, withKey: keyValue)
                variable.append(localvariable)
            }
        }
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if text != nil{
            dictionary["text"] = text
        }
        if type != nil{
            dictionary["type"] = type
        }
        /*if variable != nil{
            dictionary["variable"] = variable.toDictionary()
        }*/
        
        if variable != nil{
            var dictionaryElements = [[String:Any]]()
            for variableElement in variable {
                dictionaryElements.append(variableElement.toDictionary())
            }
            dictionary["variable"] = dictionaryElements
        }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        text = aDecoder.decodeObject(forKey: "text") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        //variable = aDecoder.decodeObject(forKey: "variable") as? SampleVariable
        variable = aDecoder.decodeObject(forKey: "variable") as? [SampleVariable]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if text != nil{
            aCoder.encode(text, forKey: "text")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if variable != nil{
            aCoder.encode(variable, forKey: "variable")
        }
    }
}
