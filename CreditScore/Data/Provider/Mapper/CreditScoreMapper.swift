//
//  CreditScoreMapper.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// CreditScoreMapper
class CreditScoreMapper {
    
    /// Transform from CreditValuesEntity to CreditScore
    ///
    /// - Parameter entity: CreditValuesEntity
    /// - Returns: CreditScore
    func transform(_ entity: CreditValuesEntity) -> CreditScore {
        
        var object = CreditScore()
        
        object.currentCreditScore = entity.creditReportInfo?.score
        object.maxCreditScore = entity.creditReportInfo?.maxScoreValue
        
        return object
    }
}
