//
//  CreditReportInfoEntity.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// CreditReportInfoEntity
struct CreditReportInfoEntity: Codable {
    
    // MARK: Public enums
    
    enum CodingKeys: String, CodingKey {
        case score
            = "score"
        case scoreBand
            = "scoreBand"
        case clientRef
            = "clientRef"
        case status
            = "status"
        case maxScoreValue
            = "maxScoreValue"
        case minScoreValue
            = "minScoreValue"
        case monthsSinceLastDefaulted
            = "monthsSinceLastDefaulted"
        case hasEverDefaulted
            = "hasEverDefaulted"
        case monthsSinceLastDelinquent
            = "monthsSinceLastDelinquent"
        case hasEverBeenDelinquent
            = "hasEverBeenDelinquent"
        case percentageCreditUsed
            = "percentageCreditUsed"
        case percentageCreditUsedDirectionFlag
            = "percentageCreditUsedDirectionFlag"
        case changedScore
            = "changedScore"
        case currentShortTermDebt
            = "currentShortTermDebt"
        case currentShortTermNonPromotionalDebt
            = "currentShortTermNonPromotionalDebt"
        case currentShortTermCreditLimit
            = "currentShortTermCreditLimit"
        case currentShortTermCreditUtilisation
            = "currentShortTermCreditUtilisation"
        case changeInShortTermDebt
            = "changeInShortTermDebt"
        case currentLongTermDebt
            = "currentLongTermDebt"
        case currentLongTermNonPromotionalDebt
            = "currentLongTermNonPromotionalDebt"
        case currentLongTermCreditLimit
            = "currentLongTermCreditLimit"
        case currentLongTermCreditUtilisation
            = "currentLongTermCreditUtilisation"
        case changeInLongTermDebt
            = "changeInLongTermDebt"
        case numPositiveScoreFactors
            = "numPositiveScoreFactors"
        case numNegativeScoreFactors
            = "numNegativeScoreFactors"
        case equifaxScoreBand
            = "equifaxScoreBand"
        case equifaxScoreBandDescription
            = "equifaxScoreBandDescription"
        case daysUntilNextReport
            = "daysUntilNextReport"
    }
    
    // MARK: Public variables
    
    var score: Int?
    var scoreBand: Int?
    var clientRef: String?
    var status: String?
    var maxScoreValue: Int?
    var minScoreValue: Int?
    var monthsSinceLastDefaulted: Int?
    var hasEverDefaulted: Bool?
    var monthsSinceLastDelinquent: Int?
    var hasEverBeenDelinquent: Bool?
    var percentageCreditUsed: Int?
    var percentageCreditUsedDirectionFlag: Int?
    var changedScore: Int?
    var currentShortTermDebt: Int?
    var currentShortTermNonPromotionalDebt: Int?
    var currentShortTermCreditLimit: Int?
    var currentShortTermCreditUtilisation: Int?
    var changeInShortTermDebt: Int?
    var currentLongTermDebt: Int?
    var currentLongTermNonPromotionalDebt: Int?
    var currentLongTermCreditLimit: Int?
    var currentLongTermCreditUtilisation: Int?
    var changeInLongTermDebt: Int?
    var numPositiveScoreFactors: Int?
    var numNegativeScoreFactors: Int?
    var equifaxScoreBand: Int?
    var equifaxScoreBandDescription: String?
    var daysUntilNextReport: Int?
}
