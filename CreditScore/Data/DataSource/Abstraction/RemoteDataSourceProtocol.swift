//
//  RemoteDataSourceProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for RemoteDataSource
protocol RemoteDataSourceProtocol {
    
    /// Load credit values
    ///
    /// - Returns: CreditValuesEntity
    /// - Throws: APIException
    func loadCreditValues() throws -> CreditValuesEntity
}
