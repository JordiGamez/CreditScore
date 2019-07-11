//
//  CreditScoreView.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

/// CreditScoreView
final class CreditScoreView: BaseView {
    
    // MARK: @IBOutlets
    
    @IBOutlet private weak var creditScoreLabel: UILabel! {
        didSet {
            hideCreditScoreLabel()
        }
    }
    @IBOutlet private weak var creditScoreValueLabel: UILabel! {
        didSet {
            hideCreditScoreValueLabel()
        }
    }
    @IBOutlet private weak var outOfLabel: UILabel! {
        didSet {
            hideOutOfLabel()
        }
    }
    
    // MARK: Private constants
    
    private let customBackgroundColor: UIColor = .clear
    private let timeInterval: TimeInterval = 0.005
    private let circleCompleteDegrees = 360
    private let outterCircleWidth: CGFloat = 200
    private let outterCircleHeight: CGFloat = 200
    private let innerCircleWidth: CGFloat = 215
    private let innerCircleHeight: CGFloat = 215
    private let outterCircleLineWidth: CGFloat = 2
    private let innerCircleLineWidth: CGFloat = 3
    private let drawCircleAnimationDuration: Double = 2
    
    // MARK: Private variables
    
    private var timer: Timer?
    private var maxScoreValue = 0
    private var currentScoreValue = 0
    private var scoreValue = 0
    
    // MARK: Public variables
    
    var creditScore: Int? = nil {
        didSet {
            if let creditScore = creditScore {
                currentScoreValue = creditScore
                creditScoreLabel.text = "creditScore_yourCreditScoreIs".localize()
            }
        }
    }
    var maxCreditScore: Int? = nil {
        didSet {
            if let maxCreditScore = maxCreditScore {
                maxScoreValue = maxCreditScore
                let baseString = "creditScore_outOf".localize()
                outOfLabel.text = baseString.replacingOccurrences(of: "%s",
                                                                  with: String(maxCreditScore))
            }
        }
    }
    
    // MARK: Overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackgroundColor()
    }
    
    // MARK: Public methods
    
    /// Show credit score
    func showCreditScore() {
        if creditScore != nil && maxCreditScore != nil {
            startTimerToUpdateCurrentScoreValue()
            drawOutterCircle()
            showCreditScoreLabel()
            showCreditScoreValueLabel()
            showOutOfLabel()
            drawInnerCircle()
        }
    }
    
    // MARK: Private methods
    
    /// Set background color
    private func setBackgroundColor() {
        backgroundColor = customBackgroundColor
    }
    
    /// Show credit score label
    private func showCreditScoreLabel() {
        creditScoreLabel.isHidden = false
    }
    
    /// Hide credit score label
    private func hideCreditScoreLabel() {
        creditScoreLabel.isHidden = true
        creditScoreLabel.text = ""
    }
    
    /// Show credit score value label
    private func showCreditScoreValueLabel() {
        creditScoreValueLabel.isHidden = false
    }
    
    /// Hide credit score value label
    private func hideCreditScoreValueLabel() {
        creditScoreValueLabel.isHidden = true
        creditScoreValueLabel.text = ""
    }
    
    /// Show out of label
    private func showOutOfLabel() {
        outOfLabel.isHidden = false
    }
    
    /// Hide out of label
    private func hideOutOfLabel() {
        outOfLabel.isHidden = true
        outOfLabel.text = ""
    }
    
    /// Start timer to update current score value
    private func startTimerToUpdateCurrentScoreValue() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(updateCurrentScoreValueLabel),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    /// Draw outter circle
    private func drawOutterCircle() {
        let outterCircleView = CircleView(
            frame: CGRect(
                x: frame.size.width / 2 - innerCircleWidth / 2,
                y: frame.size.height / 2 - innerCircleHeight / 2,
                width: innerCircleWidth,
                height: innerCircleHeight),
            strokeColor: UIColor.black.cgColor,
            lineWidth: outterCircleLineWidth)
        
        addSubview(outterCircleView)
        
        // Display circle without animation
        outterCircleView.showCircle()
    }
    
    /// Draw inner circle
    private func drawInnerCircle() {
        // Create a new CircleView
        let circleView = CircleView(
            frame: CGRect(
                x: frame.size.width / 2 - outterCircleWidth / 2,
                y: frame.size.height / 2 - outterCircleHeight / 2,
                width: outterCircleWidth,
                height: outterCircleHeight),
            strokeColor: UIColor.orange.cgColor,
            lineWidth: innerCircleLineWidth,
            percentageToDraw: CGFloat(circleCompleteDegrees * currentScoreValue
                / maxScoreValue))
        
        addSubview(circleView)
        
        // Display circle with animation
        circleView.animateCircle(duration: drawCircleAnimationDuration)
    }
    
    // MARK: Actions
    
    /// Update current score value label
    @objc private func updateCurrentScoreValueLabel() {
        creditScoreValueLabel.text = String(scoreValue)
        scoreValue += 1
        if scoreValue > currentScoreValue {
            timer?.invalidate()
            timer = nil
        }
    }
}
