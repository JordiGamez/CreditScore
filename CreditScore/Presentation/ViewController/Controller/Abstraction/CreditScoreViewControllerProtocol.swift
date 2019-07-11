//
//  CreditScoreViewControllerProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for CreditScoreViewController
protocol CreditScoreViewControllerProtocol: BaseViewControllerProtocol {
    
    /// Show loading
    func showLoading()
    
    /// Hide loading
    func hideLoading()
    
    /// Show credit score
    ///
    /// - Parameters:
    ///   - currentCreditScore: current credit score value
    ///   - maxCreditScore: maximum credit score value
    func showCreditScore(currentCreditScore: Int, maxCreditScore: Int)
    
    /// Show error
    func showError()
    
    /// Show network error
    func showNetworkError()
    
    /// Hide error
    func hideError()
}
