//
//  SampleScan.swift 
//  Created on June 21, 2019

import Foundation


class SampleScan : NSObject, NSCoding{

    var color : String!
    var criteria : [SampleCriteria]!
    var id : Int!
    var name : String!
    var tag : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        color = dictionary["color"] as? String
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        tag = dictionary["tag"] as? String
        criteria = [SampleCriteria]()
        if let criteriaArray = dictionary["criteria"] as? [[String:Any]]{
            for dic in criteriaArray{
                let value = SampleCriteria(fromDictionary: dic)
                criteria.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if color != nil{
            dictionary["color"] = color
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if tag != nil{
            dictionary["tag"] = tag
        }
        if criteria != nil{
            var dictionaryElements = [[String:Any]]()
            for criteriaElement in criteria {
                dictionaryElements.append(criteriaElement.toDictionary())
            }
            dictionary["criteria"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        color = aDecoder.decodeObject(forKey: "color") as? String
        criteria = aDecoder.decodeObject(forKey: "criteria") as? [SampleCriteria]
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        tag = aDecoder.decodeObject(forKey: "tag") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if color != nil{
            aCoder.encode(color, forKey: "color")
        }
        if criteria != nil{
            aCoder.encode(criteria, forKey: "criteria")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if tag != nil{
            aCoder.encode(tag, forKey: "tag")
        }
    }
}
