//
//  BaseView.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

/// BaseView
class BaseView: UIView {
    
    // MARK: - Private variables
    
    private var viewName: String {
        get {
            if type(of: self) == BaseView.self {
                fatalError("Error: BaseView must be subclassed")
            }
            return String(describing: type(of: self))
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .clear
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        Bundle.main.loadNibNamed(viewName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = .clear
    }
}
