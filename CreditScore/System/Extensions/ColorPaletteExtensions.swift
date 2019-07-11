//
//  ColorPaletteExtensions.swift
//  CreditScore
//
//  Created by Jordi Gámez on 11/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

extension ColorPalette {
    
    /// Transform ColorPalette hexadecimal value into UIColor
    ///
    /// - Returns: UIColor
    func hexadecimalToColor() -> UIColor {
        var colorString: String = self.rawValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }
        
        if colorString.count != 6 {
            return .gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
