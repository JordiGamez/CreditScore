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
    
    @IBOutlet private weak var messageLabel: UILabel!
    
    // MARK: Private constants
    
    private let customBackgroundColor: UIColor = .clear
    
    // MARK: Public variable
    
    var exception: APIException = .unknownException {
        didSet {
            switch exception {
            case .connectivityException:
                messageLabel.text = "networkError".localize()
            case .unknownException:
                messageLabel.text = "genericError".localize()
            }
        }
    }
    
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
