//
//  ApiClientProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 09/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for ApiClient
protocol ApiClientProtocol {
    
    /// Load credit values
    ///
    /// - Returns: CreditValuesEntity
    /// - Throws: APIException
    func loadCreditValues() throws -> CreditValuesEntity
}
