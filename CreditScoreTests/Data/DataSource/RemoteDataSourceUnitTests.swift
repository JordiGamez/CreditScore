//
//  RemoteDataSourceUnitTests.swift
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

/// RemoteDataSource unit tests
class RemoteDataSourceUnitTests: QuickSpec {
    
    // MARK: - Mocks
    
    class MockApiClient: ApiClientProtocol {
        
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
        
        var remoteDataSource: RemoteDataSource?
        var apiClient: MockApiClient?
        
        // MARK: Tests
        
        beforeEach {
            container.register(RemoteDataSource.self) { resolver in
                let remoteDataSource = RemoteDataSource()
                remoteDataSource.apiClient = resolver.resolve(MockApiClient.self)
                return remoteDataSource
            }
            container.register(MockApiClient.self) { resolver in
                return MockApiClient()
            }
            
            remoteDataSource = container.resolve(RemoteDataSource.self)
            apiClient = container.resolve(MockApiClient.self)
        }
        describe("when executing the remote data source loadCreditValues method") {
            context("given a valid response from api client") {
                beforeEach {
                    remoteDataSource?.apiClient = apiClient
                    do { _ = try remoteDataSource?.loadCreditValues() } catch {}
                }
                it("should call apiClient loadCreditValues method") {
                    expect(apiClient?.loadCreditValuesIsCalled).to(beTrue())
                }
            }
        }
        describe("when executing the remote data source loadCreditValues method") {
            context("given an exception response from api client") {
                beforeEach {
                    apiClient?.throwException = true
                    remoteDataSource?.apiClient = apiClient
                    do { _ = try remoteDataSource?.loadCreditValues() } catch {}
                }
                it("should call apiClient loadCreditValues method") {
                    expect(apiClient?.loadCreditValuesIsCalled).to(beTrue())
                }
                it("should throw unknownException from apiClient") {
                    expect { try apiClient?.loadCreditValues() }.to(throwError())
                }
            }
        }
    }
}
