//
//  CreditScorePresenterUnitTests.swift
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

/// CreditScorePresenter unit tests
class CreditScorePresenterUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCreditScoreViewController: CreditScoreViewControllerProtocol {
        
        var showLoadingIsCalled = false
        var hideLoadingIsCalled = false
        var showCreditScoreIsCalled = false
        var showErrorIsCalled = false
        var showNetworkErrorIsCalled = false
        var hideErrorIsCalled = false
        var setupViewIsCalled = false
        
        func showLoading() {
            showLoadingIsCalled = true
        }
        
        func hideLoading() {
            hideLoadingIsCalled = true
        }
        
        func showCreditScore(currentCreditScore: Int, maxCreditScore: Int) {
            showCreditScoreIsCalled = true
        }
        
        func showError() {
            showErrorIsCalled = true
        }
        
        func showNetworkError() {
            showNetworkErrorIsCalled = true
        }
        
        func hideError() {
            hideErrorIsCalled = true
        }
        
        func setupView() {
            setupViewIsCalled = true
        }
    }
    
    class MockLoadCreditScoreUseCase: LoadCreditScoreUseCaseProtocol {
        
        var executeIsCalled = false
        var throwNetworkException = false
        var throwUnknownException = false
        
        func execute() throws -> CreditScore {
            executeIsCalled = true
            if throwNetworkException { throw APIException.connectivityException }
            if throwUnknownException { throw APIException.unknownException }
            return CreditScore(currentCreditScore: 200, maxCreditScore: 700)
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var viewController: MockCreditScoreViewController?
        var presenter: CreditScorePresenter?
        var useCase: MockLoadCreditScoreUseCase?
        
        // MARK: Tests
        
        beforeEach {
            container.register(MockCreditScoreViewController.self) { resolver in
                return MockCreditScoreViewController()
            }
            container.register(CreditScorePresenter.self) { resolver in
                let presenter = CreditScorePresenter()
                presenter.loadCreditScoreUseCase = resolver.resolve(MockLoadCreditScoreUseCase.self)
                return presenter
            }
            container.register(MockLoadCreditScoreUseCase.self) { resolver in
                return MockLoadCreditScoreUseCase()
            }
            
            viewController = container.resolve(MockCreditScoreViewController.self)
            presenter = container.resolve(CreditScorePresenter.self)
            useCase = container.resolve(MockLoadCreditScoreUseCase.self)
        }
        describe("when binding view with presenter") {
            context("given a valid view protocol") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                }
                it("should bind the view with the presenter") {
                    expect(presenter?.view).to(beAKindOf(CreditScoreViewControllerProtocol.self))
                }
            }
        }
        describe("when calling viewDidLoad method") {
            context("given a valid view protocol") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.loadCreditScoreUseCase = useCase
                    presenter?.viewDidLoad()
                }
                it("should call view controller setup method") {
                    expect(viewController?.setupViewIsCalled).to(beTrue())
                }
                it("should call useCase execute method") {
                    expect(useCase?.executeIsCalled).toEventually(beTrue())
                }
            }
        }
        describe("when calling viewWillAppear method") {
            context("given a valid view protocol") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.viewWillAppear()
                }
                it("should do nothing") {}
            }
        }
        describe("when calling viewDidAppear method") {
            context("given a valid view protocol") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.viewDidAppear()
                }
                it("should do nothing") {}
            }
        }
        describe("when calling viewWillDisappear method") {
            context("given a valid view protocol") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.viewWillDisappear()
                }
                it("should do nothing") {}
            }
        }
        describe("when calling viewDidDisappear method") {
            context("given a valid view protocol") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.viewDidDisappear()
                }
                it("should do nothing") {}
            }
        }
        describe("when calling retryLoadCreditScore method") {
            context("given a valid view protocol and useCase") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    presenter?.loadCreditScoreUseCase = useCase
                    presenter?.retryLoadCreditScore()
                }
                it("should call view controller hideError method") {
                    expect(viewController?.hideErrorIsCalled).to(beTrue())
                }
                it("should call useCase execute method") {
                    expect(useCase?.executeIsCalled).to(beTrue())
                }
            }
        }
        describe("when calling retryLoadCreditScore method") {
            context("given a valid useCase and throwing connectivityException") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    useCase?.throwNetworkException = true
                    presenter?.loadCreditScoreUseCase = useCase
                    presenter?.retryLoadCreditScore()
                }
                it("should call view controller hideError method") {
                    expect(viewController?.hideErrorIsCalled).to(beTrue())
                }
                it("should call useCase execute method") {
                    expect(useCase?.executeIsCalled).toEventually(beTrue())
                }
                it("should throw connectivityException from useCase") {
                    expect { try useCase?.execute() }.to(throwError())
                }
                it("should call view controller showNetworkError method") {
                    expect(viewController?.showNetworkErrorIsCalled).toEventually(beTrue())
                }
            }
        }
        describe("when calling retryLoadCreditScore method") {
            context("given a valid useCase and throwing unknownException") {
                beforeEach {
                    presenter?.bind(view: viewController!)
                    useCase?.throwUnknownException = true
                    presenter?.loadCreditScoreUseCase = useCase
                    presenter?.retryLoadCreditScore()
                }
                it("should call view controller hideError method") {
                    expect(viewController?.hideErrorIsCalled).to(beTrue())
                }
                it("should call useCase execute method") {
                    expect(useCase?.executeIsCalled).toEventually(beTrue())
                }
                it("should throw unknownException from useCase") {
                    expect { try useCase?.execute() }.to(throwError())
                }
                it("should call view controller showErrorIsCalled method") {
                    expect(viewController?.showErrorIsCalled).toEventually(beTrue())
                }
            }
        }
    }
}
