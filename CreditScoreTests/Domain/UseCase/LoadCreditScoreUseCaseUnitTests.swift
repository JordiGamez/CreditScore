//
//  LoadCreditScoreUseCaseUnitTests.swift
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

/// LoadCreditScoreUseCase unit tests
class LoadCreditScoreUseCaseUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockCreditScoreProvider: CreditScoreProviderProtocol {
        
        var loadCreditValuesIsCalled = false
        var throwException = false
        
        func loadCreditValues() throws -> CreditScore {
            loadCreditValuesIsCalled = true
            if throwException { throw APIException.unknownException }
            return CreditScore(currentCreditScore: 200, maxCreditScore: 700)
        }
    }
    
    class MockNetworkProvider: NetworkProviderProtocol {
        
        var hasInternetConnectionIsCalled = false
        var hasInternet = true
        
        func hasInternetConnection() -> Bool {
            hasInternetConnectionIsCalled = true
            return hasInternet
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var useCase: LoadCreditScoreUseCase?
        var networkProvider: MockNetworkProvider?
        var creditScoreProvider: MockCreditScoreProvider?
        
        // MARK: Tests
        
        beforeEach {
            container.register(LoadCreditScoreUseCase.self) { resolver in
                let useCase = LoadCreditScoreUseCase()
                useCase.networkProvider = resolver.resolve(MockNetworkProvider.self)
                useCase.creditScoreProvider = resolver.resolve(MockCreditScoreProvider.self)
                return useCase
            }
            container.register(MockNetworkProvider.self) { resolver in
                return MockNetworkProvider()
            }
            container.register(MockCreditScoreProvider.self) { resolver in
                return MockCreditScoreProvider()
            }
            
            useCase = container.resolve(LoadCreditScoreUseCase.self)
            networkProvider = container.resolve(MockNetworkProvider.self)
            creditScoreProvider = container.resolve(MockCreditScoreProvider.self)
        }
        describe("when executing the use case") {
            context("given a valid internet connect") {
                beforeEach {
                    networkProvider?.hasInternet = true
                    useCase?.networkProvider = networkProvider
                    useCase?.creditScoreProvider = creditScoreProvider
                    _ = try! useCase?.execute()
                }
                it("should call networkProvider hasInternetConnection method") {
                    expect(networkProvider?.hasInternetConnectionIsCalled).to(beTrue())
                }
                it("should call creditScoreProvider loadCreditValues method") {
                    expect(creditScoreProvider?.loadCreditValuesIsCalled).to(beTrue())
                }
            }
        }
        describe("when executing the use case") {
            context("given a valid internet connection but provider is throwing exception") {
                beforeEach {
                    networkProvider?.hasInternet = true
                    useCase?.networkProvider = networkProvider
                    creditScoreProvider?.throwException = true
                    useCase?.creditScoreProvider = creditScoreProvider
                    do { _ = try useCase?.execute() } catch {}
                }
                it("should call networkProvider hasInternetConnection method") {
                    expect(networkProvider?.hasInternetConnectionIsCalled).to(beTrue())
                }
                it("should call creditScoreProvider loadCreditValues method") {
                    expect(creditScoreProvider?.loadCreditValuesIsCalled).to(beTrue())
                }
                it("should throw unknownException from creditScoreProvider") {
                    expect { try creditScoreProvider?.loadCreditValues() }.to(throwError())
                }
            }
        }
        describe("when executing the use case") {
            context("given an invalid internet connection") {
                beforeEach {
                    networkProvider?.hasInternet = false
                    useCase?.networkProvider = networkProvider
                    creditScoreProvider?.throwException = true
                    useCase?.creditScoreProvider = creditScoreProvider
                    do { _ = try useCase?.execute() } catch {}
                }
                it("should call networkProvider hasInternetConnection method") {
                    expect(networkProvider?.hasInternetConnectionIsCalled).to(beTrue())
                }
                it("should not call creditScoreProvider loadCreditValues method") {
                    expect(creditScoreProvider?.loadCreditValuesIsCalled).to(beFalse())
                }
                it("should throw connectivityException from creditScoreProvider") {
                    expect { try creditScoreProvider?.loadCreditValues() }.to(throwError())
                }
            }
        }
    }
}
