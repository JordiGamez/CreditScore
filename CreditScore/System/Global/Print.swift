//
//  Print.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import Foundation

/// Override print method to be only displayed when Debug environment
///
/// - Parameter string: Text to be displayed
func print(_ string: Any) {
    #if DEBUG
    print(string, separator: " ", terminator: "\n")
    #endif
}
