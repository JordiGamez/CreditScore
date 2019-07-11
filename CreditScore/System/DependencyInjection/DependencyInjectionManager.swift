//
//  DependencyInjectionManager.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Swinject

/// Manager used for injecting all the dependencies in the project
class DependencyInjectionManager {
    
    // MARK: Constants
    
    let container = Container()
    
    // MARK: Initializers
    
    init() {
        registerViewControllers()
        registerPresenters()
        registerRouters()
        registerUseCases()
        registerProviders()
        registerDataSources()
        registerClients()
    }
    
    // MARK: Private methods
    
    private func registerViewControllers() {
        container.register(CreditScoreViewController.self) { resolver in
            let viewController = CreditScoreViewController()
            viewController.presenter = resolver.resolve(CreditScorePresenterProtocol.self)
            return viewController
        }
    }
    
    private func registerPresenters() {
        container.register(CreditScorePresenterProtocol.self) { resolver in
            let presenter = CreditScorePresenter()
            presenter.loadCreditScoreUseCase = resolver.resolve(LoadCreditScoreUseCaseProtocol.self)
            return presenter
        }
    }
    
    private func registerRouters() {
        
    }
    
    private func registerUseCases() {
        container.register(LoadCreditScoreUseCaseProtocol.self) { resolver in
            let useCase = LoadCreditScoreUseCase()
            useCase.networkProvider = resolver.resolve(NetworkProviderProtocol.self)
            useCase.creditScoreProvider = resolver.resolve(CreditScoreProviderProtocol.self)
            return useCase
        }
    }
    
    private func registerProviders() {
        container.register(NetworkProviderProtocol.self) { resolver in
            return NetworkProvider()
        }
        container.register(CreditScoreProviderProtocol.self) { resolver in
            let provider = CreditScoreProvider()
            provider.remoteDataSource = resolver.resolve(RemoteDataSourceProtocol.self)
            return provider
        }
    }
    
    private func registerDataSources() {
        container.register(RemoteDataSourceProtocol.self) { resolver in
            let dataSource = RemoteDataSource()
            dataSource.apiClient = resolver.resolve(ApiClientProtocol.self)
            return dataSource
        }
    }
    
    private func registerClients() {
        container.register(ApiClientProtocol.self) { resolver in
            return ApiClient()
        }
    }
}
