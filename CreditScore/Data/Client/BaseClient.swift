//
//  BaseClient.swift
//  CreditScore
//
//  Created by Jordi Gámez on 09/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous

/// BaseClient
class BaseClient {
    
    // MARK: Public methods
    
    func request(_ endpoint: APIEndpoint, attempt: Int = 0,
                 maxNumberOfTries: Int = 3, delayTimeBetweenTries: UInt32 = 3) throws -> APIResponse? {
        
        let response = Alamofire.request("\(endpoint.host)/\(endpoint.api)/\(endpoint.path)",
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers)
            .validate()
            .responseJSON()
        
        print("API REQUEST:")
        print("- URL: \(endpoint.host)/\(endpoint.api)/\(endpoint.path)")
        print("- Parameters: \(String(describing: endpoint.parameters))")
        print("- Headers: \(String(describing: endpoint.headers?.description))")
        print("- Response headers: \(String(describing: response.response?.allHeaderFields.description))")
        print("- Method: \(endpoint.method)")
        print("- Encoding: \(endpoint.encoding)")
        print("- Attempt: \(attempt)")
        print("- Response code: \(String(describing: response.response?.statusCode))")
        print("- Response: \(response.description)")
        print("------------")
        
        switch response.result {
        case .success:
            return APIResponse(data: response.data)
        case .failure:
            if attempt < maxNumberOfTries {
                sleep(delayTimeBetweenTries)
                do {
                    _ = try self.request(endpoint, attempt: attempt + 1, maxNumberOfTries: maxNumberOfTries,
                                         delayTimeBetweenTries: delayTimeBetweenTries)
                } catch let exception as APIException {
                    throw exception
                }
            } else {
                if let data = response.data {
                    print(String(data: data, encoding: String.Encoding.utf8) ?? "")
                }
                throw APIException.connectivityException
            }
        }
        throw APIException.unknownException
    }
}
