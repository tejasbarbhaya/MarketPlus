//
//  SampleVariable.swift
//  Created on June 21, 2019

import Foundation


class SampleVariable : NSObject, NSCoding{

    var varKeyName : Sample4!
    var keyValue : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any], withKey:String){
        if let Data = dictionary[withKey] as? [String:Any]{
            keyValue = withKey
            varKeyName = Sample4(fromDictionary: Data)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if varKeyName != nil{
            //dictionary["4"] = varKeyName.toDictionary()
            dictionary[keyValue] = varKeyName.toDictionary()
            
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        //varKeyName = aDecoder.decodeObject(forKey: "$4") as? Sample4
        varKeyName = aDecoder.decodeObject(forKey: keyValue) as? Sample4
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if varKeyName != nil{
            //aCoder.encode(4, forKey: "$4")
            aCoder.encode(4, forKey: keyValue)
        }
    }
}
