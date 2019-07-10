//
//  CreditScoreProvider.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// CreditScoreProvider
final class CreditScoreProvider {
    
    // MARK: Public variables
    
    var remoteDataSource: RemoteDataSourceProtocol?
}

// MARK: - CreditScoreProviderProtocol protocol conformance

extension CreditScoreProvider: CreditScoreProviderProtocol {
    
    /// Load credit values
    ///
    /// - Returns: CreditScore
    /// - Throws: APIException
    func loadCreditValues() throws -> CreditScore {
        do {
            if let result = try remoteDataSource?.loadCreditValues() {
                let mapper = CreditScoreMapper()
                return mapper.transform(result)
            }
            throw APIException.unknownException
        } catch let exception as APIException {
            throw exception
        }
    }
}
