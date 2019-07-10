//
//  ApiClient.swift
//  CreditScore
//
//  Created by Jordi Gámez on 09/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Api client
final class ApiClient: BaseClient {}

// MARK: - ApiClientProtocol protocol conformance

extension ApiClient: ApiClientProtocol {
    
    /// Load credit values
    ///
    /// - Returns: CreditValuesEntity
    /// - Throws: APIException
    func loadCreditValues() throws -> CreditValuesEntity {
        do {
            if let result = try request(.values) {
                if let data = result.data {
                    let decodeResult = try Decoder().decode(CreditValuesEntity.self, from: data)
                    return decodeResult
                }
            }
            throw APIException.unknownException
        } catch let exception as APIException {
            throw exception
        }
    }
}
