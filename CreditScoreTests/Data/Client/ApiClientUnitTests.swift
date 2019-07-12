//
//  ApiClientUnitTests.swift
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

/// ApiClient unit tests
class ApiClientUnitTests: QuickSpec {
    
    // MARK: - Tests
    
    override func spec() {
        
        // MARK: Constants
        
        let container = Container()
        
        // MARK: Variables
        
        var apiClient: ApiClient?
        
        // MARK: Tests
        
        beforeEach {
            container.register(ApiClient.self) { resolver in
                return ApiClient()
            }
            
            apiClient = container.resolve(ApiClient.self)
        }
        describe("when executing the api client loadCreditValues method") {
            context("given a valid response from base client") {
                beforeEach {
                    do { _ = try apiClient?.loadCreditValues() } catch {}
                }
            }
        }
    }
}
