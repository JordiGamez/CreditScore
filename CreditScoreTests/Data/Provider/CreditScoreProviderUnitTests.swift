//
//  CreditScoreProviderUnitTests.swift
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

/// CreditScoreProvider unit tests
class CreditScoreProviderUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockRemoteDataSource: RemoteDataSourceProtocol {
        
        var loadCreditValuesIsCalled = false
        var throwException = false
        
        func loadCreditValues() throws -> CreditValuesEntity {
            loadCreditValuesIsCalled = true
            if throwException { throw APIException.unknownException }
            return CreditValuesEntity()
        }
    }
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var provider: CreditScoreProvider?
        var remoteDataSource: MockRemoteDataSource?
        
        // MARK: Tests
        
        beforeEach {
            container.register(CreditScoreProvider.self) { resolver in
                let provider = CreditScoreProvider()
                provider.remoteDataSource = resolver.resolve(MockRemoteDataSource.self)
                return provider
            }
            container.register(MockRemoteDataSource.self) { resolver in
                return MockRemoteDataSource()
            }
            
            provider = container.resolve(CreditScoreProvider.self)
            remoteDataSource = container.resolve(MockRemoteDataSource.self)
        }
        describe("when executing the provider") {
            context("given a valid response from remote data source") {
                beforeEach {
                    provider?.remoteDataSource = remoteDataSource
                    do { _ = try provider?.loadCreditValues() } catch {}
                }
                it("should call remoteDataSource loadCreditValues method") {
                    expect(remoteDataSource?.loadCreditValuesIsCalled).to(beTrue())
                }
            }
        }
        describe("when executing the provider") {
            context("given an exception response from remote data source") {
                beforeEach {
                    remoteDataSource?.throwException = true
                    provider?.remoteDataSource = remoteDataSource
                    do { _ = try provider?.loadCreditValues() } catch {}
                }
                it("should call remoteDataSource loadCreditValues method") {
                    expect(remoteDataSource?.loadCreditValuesIsCalled).to(beTrue())
                }
                it("should throw unknownException from remoteDataSource") {
                    expect { try remoteDataSource?.loadCreditValues() }.to(throwError())
                }
            }
        }
    }
}
