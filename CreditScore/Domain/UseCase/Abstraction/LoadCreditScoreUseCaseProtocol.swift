//
//  LoadCreditScoreUseCaseProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for LoadCreditScoreUseCase
protocol LoadCreditScoreUseCaseProtocol {
    
    /// Execute the use case
    ///
    /// - Returns: CreditScore
    /// - Throws: APIException
    func execute() throws -> CreditScore
}
