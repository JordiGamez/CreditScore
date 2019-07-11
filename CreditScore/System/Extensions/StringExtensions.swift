//
//  StringExtensions.swift
//  CreditScore
//
//  Created by Jordi Gámez on 11/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

extension String {
    
    /// Localize
    ///
    /// - Returns: Lozalized string
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
