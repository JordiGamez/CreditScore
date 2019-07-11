//
//  BasePresenterProtocol.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Abstraction for BasePresenter
protocol BasePresenterProtocol {
    
    /// Tells the presenter that the view has loaded
    func viewDidLoad()
    
    /// Tells the presenter that the view will appear
    func viewWillAppear()
    
    /// Tells the presenter that the view has appeared
    func viewDidAppear()
    
    /// Tells the presenter that the view will disappear
    func viewWillDisappear()
    
    /// Tells the presenter that the view has disappeared
    func viewDidDisappear()
}
