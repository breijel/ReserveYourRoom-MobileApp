//
//  RestService.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 20/09/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class InfrastructureService: NSObject {
    
    static let sharedInstance = InfrastructureService()
    
    let baseURL = "http://localhost:8080/reserveyourroom/api"
    
    func getAll(_ onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL+"/infrastructure"
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
}
