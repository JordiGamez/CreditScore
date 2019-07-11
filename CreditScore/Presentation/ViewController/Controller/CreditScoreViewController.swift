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
    @IBOutlet weak var creditScoreView: CreditScoreView!
    @IBOutlet weak var retryButton: UIButton! {
        didSet {
            retryButton.isHidden = true
            retryButton.setTitle("Retry", for: .normal)
            retryButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
            retryButton.tintColor = .white
            retryButton.backgroundColor = .black
            retryButton.layer.cornerRadius = 4
            retryButton.addTarget(self,
                                  action: #selector(retryCreditScore),
                                  for: .touchUpInside)
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
    
    // MARK: Actions
    
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
        // TODO: Implement
    }
    
    /// Hide loading
    func hideLoading() {
        // TODO: Implement
    }
    
    /// Show credit score
    ///
    /// - Parameters:
    ///   - currentCreditScore: current credit score value
    ///   - maxCreditScore: maximum credit score value
    func showCreditScore(currentCreditScore: Int, maxCreditScore: Int) {
        creditScoreView.maxCreditScore = maxCreditScore
        creditScoreView.creditScore = currentCreditScore
        creditScoreView.showCreditScore()
    }
    
    /// Show error
    func showError() {
        // TODO: Implement
        retryButton.isHidden = false
    }
}
