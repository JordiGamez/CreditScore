//
//  CreditValuesEntity.swift
//  CreditScore
//
//  Created by Jordi Gámez on 09/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// CreditValuesEntity
struct CreditValuesEntity: Codable {
    
    // MARK: Public enums
    
    enum CodingKeys: String, CodingKey {
        case accountIDVStatus       = "accountIDVStatus"
        case creditReportInfo       = "creditReportInfo"
        case dashboardStatus        = "dashboardStatus"
        case personaType            = "personaType"
        case coachingSummary        = "coachingSummary"
        case augmentedCreditScore   = "augmentedCreditScore"
    }
    
    // MARK: Public variables
    
    var accountIDVStatus: String?
    var creditReportInfo: CreditReportInfoEntity?
    var dashboardStatus: String?
    var personaType: String?
    var coachingSummary: CoachingSummary?
    var augmentedCreditScore: String?
}
