//
//  LoadCreditScoreUseCase.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// LoadCreditScoreUseCase
final class LoadCreditScoreUseCase: BaseUseCase {
    
    // MARK: Public variables
    
    var creditScoreProvider: CreditScoreProviderProtocol?
}

// MARK: - LoadCreditScoreUseCaseProtocol protocol conformance

extension LoadCreditScoreUseCase: LoadCreditScoreUseCaseProtocol {
    
    /// Execute the use case
    ///
    /// - Returns: CreditScore
    /// - Throws: APIException
    func execute() throws -> CreditScore {
        guard let hasInternetConnection = networkProvider?.hasInternetConnection() else { throw APIException.connectivityException
        }
        if !hasInternetConnection { throw APIException.connectivityException }
        
        do {
            if let result = try creditScoreProvider?.loadCreditValues() {
                return result
            }
            throw APIException.unknownException
        } catch let exception as APIException {
            throw exception
        }
    }
}
