//
//  CreditScoreProviderProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for CreditScoreProvider
protocol CreditScoreProviderProtocol {
    
    /// Load credit values
    ///
    /// - Returns: CreditScore
    /// - Throws: APIException
    func loadCreditValues() throws -> CreditScore
}
