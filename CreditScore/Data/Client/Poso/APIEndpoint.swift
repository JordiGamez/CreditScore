//
//  APIEndpoint.swift
//  CreditScore
//
//  Created by Jordi Gámez on 09/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation
import Alamofire

/// APIEndpoint
enum APIEndpoint {
    
    // MARK: Endpoints
    
    case values
    
    // MARK: Public variables
    
    var host: String {
        return Constants.API.Host.Api.pro
    }
    
    var api: String {
        return Constants.API.Api.Api.api
    }
    
    var path: String {
        switch self {
        case .values: return "values"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default: return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default: return nil
        }
    }
}
