//
//  LoadingView.swift
//  CreditScore
//
//  Created by Jordi Gámez on 11/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

/// LoadingView
final class LoadingView: BaseView {
    
    // MARK: @IBOutlets
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    @IBOutlet private weak var messageLabel: UILabel! {
        didSet {
            messageLabel.isHidden = true
        }
    }
    
    // MARK: Private constants
    
    private let customBackgroundColor: UIColor = .clear
    
    // MARK: Public variables
    
    var message: String? = nil {
        didSet {
            if let message = message {
                messageLabel.text = message
                messageLabel.isHidden = false
            }
        }
    }
    
    // MARK: Overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackgroundColor()
    }
    
    // MARK: Public methods
    
    /// Show loading
    func showLoading() {
        
    }
    
    /// Hide loading
    func hideLoading() {
        
    }
    
    // MARK: Private methods
    
    /// Set background color
    private func setBackgroundColor() {
        backgroundColor = customBackgroundColor
    }
}
