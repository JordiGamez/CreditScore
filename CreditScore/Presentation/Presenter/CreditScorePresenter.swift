//
//  CreditScorePresenter.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// CreditScorePresenter
final class CreditScorePresenter {
    
    // MARK: Private variables
    
    private var loadCreditScoreUseCaseInProgress = false {
        didSet {
            if loadCreditScoreUseCaseInProgress {
                DispatchQueue.main.async { self.view?.showLoading() }
            } else {
                DispatchQueue.main.async { self.view?.hideLoading() }
            }
        }
    }
    
    // MARK: Public variables
    
    var view: CreditScoreViewControllerProtocol?
    var loadCreditScoreUseCase: LoadCreditScoreUseCaseProtocol?
    
    // MARK: Private methods
    
    /// Load credit score
    private func loadCreditScore() {
        self.loadCreditScoreUseCaseInProgress = true
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let result = try self.loadCreditScoreUseCase?.execute() {
                    self.loadCreditScoreUseCaseInProgress = false
                    if let currentCreditScore = result.currentCreditScore,
                        let maxCreditScore = result.maxCreditScore {
                        DispatchQueue.main.async {
                            self.view?.showCreditScore(currentCreditScore: currentCreditScore,
                                                   maxCreditScore: maxCreditScore)
                            return
                        }
                    }
                }
            } catch {
                self.loadCreditScoreUseCaseInProgress = false
                DispatchQueue.main.async { self.view?.showError() }
            }
        }
    }
}

// MARK: - CreditScorePresenterProtocol protocol conformance

extension CreditScorePresenter: CreditScorePresenterProtocol {
    
    /// Tells the presenter that the view has loaded
    func viewDidLoad() {
        view?.setupView()
        loadCreditScore()
    }
    
    /// Tells the presenter that the view will appear
    func viewWillAppear() {
        // Do nothing
    }
    
    /// Tells the presenter that the view has appeared
    func viewDidAppear() {
        // Do nothing
    }
    
    /// Tells the presenter that the view will disappear
    func viewWillDisappear() {
        // Do nothing
    }
    
    /// Tells the presenter that the view has disappeared
    func viewDidDisappear() {
        // Do nothing
    }
    
    /// Bind the view with the presenter
    ///
    /// - Parameter view: CreditScoreViewControllerProtocol object
    func bind(view: CreditScoreViewControllerProtocol) {
        self.view = view
    }
    
    /// Retry load credit score
    func retryLoadCreditScore() {
        view?.hideError()
        loadCreditScore()
    }
}
