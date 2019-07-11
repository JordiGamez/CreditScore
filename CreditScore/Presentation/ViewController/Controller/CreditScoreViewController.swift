//
//  CreditScoreViewController.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

/// CreditScore screen
class CreditScoreViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.barTintColor = .black
            navigationBar.isTranslucent = false
            let title = UILabel(frame: .zero)
            title.text = "creditScore_dashboard".localize()
            title.textColor = .white
            navigationBar.topItem?.titleView = title
        }
    }
    @IBOutlet weak var creditScoreView: CreditScoreView! {
        didSet {
            creditScoreView.isHidden = true
        }
    }
    @IBOutlet weak var loadingView: LoadingView! {
        didSet {
            loadingView.isHidden = true
        }
    }
    @IBOutlet weak var retryButton: UIButton! {
        didSet {
            retryButton.isHidden = true
            retryButton.setTitle("tryAgain".localize(), for: .normal)
            retryButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
            retryButton.tintColor = .white
            retryButton.backgroundColor = .black
            retryButton.layer.cornerRadius = 4
            retryButton.addTarget(self,
                                  action: #selector(retryCreditScore),
                                  for: .touchUpInside)
        }
    }
    @IBOutlet weak var errorView: ErrorView! {
        didSet {
            errorView.isHidden = true
        }
    }
    
    // MARK: Public variables
    
    var presenter: CreditScorePresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindPresenter()
        presenter?.viewDidLoad()
    }
    
    // MARK: Private methods
    
    /// Bind the view with the presenter
    private func bindPresenter() {
        presenter?.bind(view: self)
    }
    
    /// Display UI error
    private func displayUIError() {
        errorView.isHidden = false
        retryButton.isHidden = false
    }
    
    // MARK: Actions
    
    /// Retry load credit score
    @objc private func retryCreditScore() {
        presenter?.retryLoadCreditScore()
    }
}

// MARK: - CreditScoreViewControllerProtocol protocol conformance

extension CreditScoreViewController: CreditScoreViewControllerProtocol {
    
    /// Setup current view
    func setupView() {
        view.backgroundColor = .white
    }
    
    /// Show loading
    func showLoading() {
        loadingView.isHidden = false
        loadingView.message = "creditScore_calculating".localize()
    }
    
    /// Hide loading
    func hideLoading() {
        loadingView.isHidden = true
    }
    
    /// Show credit score
    ///
    /// - Parameters:
    ///   - currentCreditScore: current credit score value
    ///   - maxCreditScore: maximum credit score value
    func showCreditScore(currentCreditScore: Int, maxCreditScore: Int) {
        creditScoreView.isHidden = false
        creditScoreView.maxCreditScore = maxCreditScore
        creditScoreView.creditScore = currentCreditScore
        creditScoreView.showCreditScore()
    }
    
    /// Show error
    func showError() {
        errorView.exception = .unknownException
        displayUIError()
    }
    
    /// Show network error
    func showNetworkError() {
        errorView.exception = .connectivityException
        displayUIError()
    }
    
    /// Hide error
    func hideError() {
        errorView.isHidden = true
        retryButton.isHidden = true
    }
}
