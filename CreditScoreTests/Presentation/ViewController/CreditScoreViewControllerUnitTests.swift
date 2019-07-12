//
//  CreditScoreViewControllerUnitTests.swift
//  CreditScoreTests
//
//  Created by Jordi Gámez on 12/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Swinject
@testable import CreditScore

/// CreditScoreViewController unit tests
class CreditScoreViewControllerUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCreditScorePresenter: CreditScorePresenterProtocol {
        
        var viewDidLoadIsCalled = false
        var viewWillAppearIsCalled = false
        var viewDidAppearIsCalled = false
        var viewWillDisappearIsCalled = false
        var viewDidDisappearIsCalled = false
        var bindIsCalled = false
        var retryLoadCreditScoreIsCalled = false
        
        func viewDidLoad() {
            viewDidLoadIsCalled = true
        }
        
        func viewWillAppear() {
            viewWillAppearIsCalled = true
        }
        
        func viewDidAppear() {
            viewDidAppearIsCalled = true
        }
        
        func viewWillDisappear() {
            viewWillDisappearIsCalled = true
        }
        
        func viewDidDisappear() {
            viewDidDisappearIsCalled = true
        }
        
        func bind(view: CreditScoreViewControllerProtocol) {
            bindIsCalled = true
        }
        
        func retryLoadCreditScore() {
            retryLoadCreditScoreIsCalled = true
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var viewController: CreditScoreViewController?
        var presenter: MockCreditScorePresenter?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CreditScoreViewController.self) { resolver in
                let viewController = CreditScoreViewController()
                viewController.presenter = resolver.resolve(MockCreditScorePresenter.self)
                return viewController
            }
            container.register(MockCreditScorePresenter.self) { resolver in
                MockCreditScorePresenter()
            }
            
            viewController = container.resolve(CreditScoreViewController.self)
            presenter = container.resolve(MockCreditScorePresenter.self)
        }
        describe("when viewDidLoad is called") {
            context("given a valid presenter") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.viewDidLoad()
                }
                it("should call bind presenter method") {
                    expect(presenter?.bindIsCalled).to(beTrue())
                }
                it("should call viewDidLoad presenter method") {
                    expect(presenter?.viewDidLoadIsCalled).to(beTrue())
                }
            }
        }
        describe("when setupView is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.setupView()
                }
                it("should set the background color to white") {
                    expect(viewController?.view.backgroundColor).to(equal(UIColor.white))
                }
            }
        }
        describe("when showLoading is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.showLoading()
                }
                it("should set the loadingView hidden status to false") {
                    expect(viewController?.loadingView.isHidden).to(beFalse())
                }
                it("should set the loadingView message string to creditScore_calculating") {
                    expect(viewController?.loadingView.message).to(equal("creditScore_calculating".localize()))
                }
            }
        }
        describe("when hideLoading is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.hideLoading()
                }
                it("should set the loadingView hidden status to true") {
                    expect(viewController?.loadingView.isHidden).to(beTrue())
                }
            }
        }
        describe("when showCreditScore is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.showCreditScore(
                        currentCreditScore: 200,
                        maxCreditScore: 700)
                }
                it("should set the creditScoreView hidden status to false") {
                    expect(viewController?.creditScoreView.isHidden).to(beFalse())
                }
                it("should set the creditScoreView maxCreditScore value to 700") {
                    expect(viewController?.creditScoreView.maxCreditScore).to(equal(700))
                }
                it("should call creditScoreView creditScore value to 200") {
                    expect(viewController?.creditScoreView.creditScore).to(equal(200))
                }
            }
        }
        describe("when showError is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.showError()
                }
                it("should set the errorView exception value to .unknownException") {
                    expect(viewController?.errorView.exception).to(equal(APIException.unknownException))
                }
                it("should set the errorView hidden status to false") {
                    expect(viewController?.errorView.isHidden).to(beFalse())
                }
                it("should set the retryButton hidden status to false") {
                    expect(viewController?.retryButton.isHidden).to(beFalse())
                }
            }
        }
        describe("when showNetworkError is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.showNetworkError()
                }
                it("should set the errorView exception value to .connectivityException") {
                    expect(viewController?.errorView.exception).to(equal(APIException.connectivityException))
                }
                it("should set the errorView hidden status to false") {
                    expect(viewController?.errorView.isHidden).to(beFalse())
                }
                it("should set the retryButton hidden status to false") {
                    expect(viewController?.retryButton.isHidden).to(beFalse())
                }
            }
        }
        describe("when hideError is called") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.loadView()
                    viewController?.hideError()
                }
                it("should set the errorView hidden status to true") {
                    expect(viewController?.errorView.isHidden).to(beTrue())
                }
                it("should set the retryButton hidden status to true") {
                    expect(viewController?.retryButton.isHidden).to(beTrue())
                }
            }
        }
        describe("when retryButton is called using .touchUpInside") {
            context("given a valid protocol conformance") {
                beforeEach {
                    viewController?.presenter = presenter
                    viewController?.viewDidLoad()
                    viewController?.loadView()
                    viewController?.retryButton.sendActions(for: .touchUpInside)
                }
                it("should call the presenter retryLoadCreditScore method") {
                    expect(presenter?.retryLoadCreditScoreIsCalled).to(beTrue())
                }
            }
        }
    }
}
