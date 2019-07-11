//
//  ErrorView.swift
//  CreditScore
//
//  Created by Jordi Gámez on 11/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

/// ErrorView
final class ErrorView: BaseView {
    
    // MARK: @IBOutlets
    
    @IBOutlet private weak var messageLabel: UILabel! {
        didSet {
            messageLabel.text = "Error"
        }
    }
    
    // MARK: Private constants
    
    private let customBackgroundColor: UIColor = .clear
    
    // MARK: Overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackgroundColor()
    }
    
    // MARK: Private methods
    
    /// Set background color
    private func setBackgroundColor() {
        backgroundColor = customBackgroundColor
    }
}
