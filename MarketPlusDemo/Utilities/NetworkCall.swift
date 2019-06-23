//
//  NetworkCall.swift
//  MarketPlusDemo
//
//  Created by Tejash on 21/06/19.
//  Copyright © 2019 Tejas. All rights reserved.
//

import Foundation

class NetworkCall: NSObject {
    static var objNetworkCall : NetworkCall? = nil

    static func createNetworkClassObject() -> NetworkCall {
        if objNetworkCall == nil {
            objNetworkCall = NetworkCall.init()
        }
        
        return objNetworkCall!
    }
    
    func networkCall(completion: @escaping (_ response: Any?,_ error: Error?) -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://mp-android-challenge.herokuapp.com/data")!
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil,error)
            } else {
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        data!, options: .allowFragments)
                    //print(jsonResponse) //Response result
                    completion(jsonResponse,error)
                } catch let parsingError {
                    print("Error", parsingError)
                    completion(nil,parsingError)
                }
            }
        }
        task.resume()
    }
}
