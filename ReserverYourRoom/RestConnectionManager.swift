//
//  RestApiManager.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 13/09/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestConnectionManager: NSObject {
    static let sharedInstance = RestConnectionManager()
    
    // MARK: Perform a GET Request
    func makeHTTPGetRequest(_ path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: URL(string: path)!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error as NSError?)
            } else {
                onCompletion(nil, error as NSError?)
            }
        }
        task.resume()
    }
    
    // MARK: Perform a POST Request
    func makeHTTPPostRequest(_ path: String, body: [String: AnyObject], onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: URL(string: path)!)
        
        // Set the method to POST
        request.httpMethod = "DELETE"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            // Set the POST body for the request
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error as NSError?)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            print("Error during POST request")
            onCompletion(nil, nil)
        }
    }
}
