//
//  NetworkProviderProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for NetworkProvider
protocol NetworkProviderProtocol {
    
    /// Check if there is a valid Internet connection
    ///
    /// - Returns: True if device has Internet connection, false otherwise
    func hasInternetConnection() -> Bool
}
