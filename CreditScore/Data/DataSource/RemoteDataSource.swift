//
//  RemoteDataSource.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Remote data source
final class RemoteDataSource {
    
    // MARK: Public variables
    
    var apiClient: ApiClientProtocol?
}

// MARK: - RemoteDataSourceProtocol protocol conformance

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    /// Load credit values
    ///
    /// - Returns: CreditValuesEntity
    /// - Throws: APIException
    func loadCreditValues() throws -> CreditValuesEntity {
        do {
            if let result = try apiClient?.loadCreditValues() {
                return result
            }
            throw APIException.unknownException
        } catch let exception as APIException {
            throw exception
        }
    }
}
