//
//  CGFloatExtensions.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

extension CGFloat {
    
    /// Transform from degrees to radians
    ///
    /// - Returns: CGFloat in radians format
    func degreesToRadians() -> CGFloat {
        return self * .pi / 180
    }
}
