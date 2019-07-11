//
//  BaseViewController.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

/// BaseViewController
class BaseViewController: UIViewController {
    
    // MARK: - Private constants
    
    private let statusBarKey = "statusBarWindow.statusBar"
    private let statusBarBackgroundColor: UIColor = .black
    
    // MARK: - Initializers
    
    init() {
        if type(of: self) == BaseViewController.self {
            fatalError("Error: BaseViewController must be subclassed")
        }
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
        setStatusBarBackgroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Private methods
    
    /// Set custom status bar background
    private func setStatusBarBackgroundColor() {
        guard let statusBarView = UIApplication.shared.value(forKeyPath: statusBarKey) as? UIView else {
            return
        }
        statusBarView.backgroundColor = statusBarBackgroundColor
    }
}
