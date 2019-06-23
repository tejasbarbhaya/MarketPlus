//
//  Sample$4.swift
//  Created on June 21, 2019

import Foundation


class Sample4 : NSObject, NSCoding{

    var defaultValue : Int!
    var maxValue : Int!
    var minValue : Int!
    var parameterName : String!
    var studyType : String!
    var type : String!
    var values1 : [Double]!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        defaultValue = dictionary["default_value"] as? Int
        maxValue = dictionary["max_value"] as? Int
        minValue = dictionary["min_value"] as? Int
        parameterName = dictionary["parameter_name"] as? String
        studyType = dictionary["study_type"] as? String
        type = dictionary["type"] as? String
        
        if let values1Array = dictionary["values"] as? [Double]{
            values1 = values1Array
        }
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if defaultValue != nil{
            dictionary["default_value"] = defaultValue
        }
        if maxValue != nil{
            dictionary["max_value"] = maxValue
        }
        if minValue != nil{
            dictionary["min_value"] = minValue
        }
        if parameterName != nil{
            dictionary["parameter_name"] = parameterName
        }
        if studyType != nil{
            dictionary["study_type"] = studyType
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        defaultValue = aDecoder.decodeObject(forKey: "default_value") as? Int
        maxValue = aDecoder.decodeObject(forKey: "max_value") as? Int
        minValue = aDecoder.decodeObject(forKey: "min_value") as? Int
        parameterName = aDecoder.decodeObject(forKey: "parameter_name") as? String
        studyType = aDecoder.decodeObject(forKey: "study_type") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        
        values1 = aDecoder.decodeObject(forKey: "values") as! [Double]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if defaultValue != nil{
            aCoder.encode(defaultValue, forKey: "default_value")
        }
        if maxValue != nil{
            aCoder.encode(maxValue, forKey: "max_value")
        }
        if minValue != nil{
            aCoder.encode(minValue, forKey: "min_value")
        }
        if parameterName != nil{
            aCoder.encode(parameterName, forKey: "parameter_name")
        }
        if studyType != nil{
            aCoder.encode(studyType, forKey: "study_type")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if values1 != nil{
            aCoder.encode(values1, forKey: "values")
        }
    }
}
