//
//  CreditScorePresenterProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for CreditScorePresenter
protocol CreditScorePresenterProtocol: BasePresenterProtocol {
    
    /// Bind the view with the presenter
    ///
    /// - Parameter view: CreditScoreViewControllerProtocol object
    func bind(view: CreditScoreViewControllerProtocol)
    
    /// Retry load credit score
    func retryLoadCreditScore()
}
