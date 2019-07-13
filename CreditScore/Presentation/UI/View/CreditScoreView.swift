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
    private let innerCircleWidth: CGFloat = 200
    private let innerCircleHeight: CGFloat = 200
    private let outterCircleWidth: CGFloat = 215
    private let outterCircleHeight: CGFloat = 215
    private let innerCircleLineWidth: CGFloat = 3
    private let outterCircleLineWidth: CGFloat = 2
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
                outOfLabel.text =
                    baseString.replacingOccurrences(of: "%s",
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
        hidePreviousScore()
        removePreviousCircles()
        if creditScore != nil && maxCreditScore != nil {
            startTimerToUpdateCurrentScoreValue()
            drawOutterCircle()
            showCurrentScore()
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
    }
    
    /// Show credit score value label
    private func showCreditScoreValueLabel() {
        creditScoreValueLabel.isHidden = false
    }
    
    /// Hide credit score value label
    private func hideCreditScoreValueLabel() {
        creditScoreValueLabel.isHidden = true
    }
    
    /// Show out of label
    private func showOutOfLabel() {
        outOfLabel.isHidden = false
    }
    
    /// Hide out of label
    private func hideOutOfLabel() {
        outOfLabel.isHidden = true
    }
    
    /// Start timer to update current score value
    private func startTimerToUpdateCurrentScoreValue() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(
                                        updateCurrentScoreValueLabel),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    /// Draw outter circle
    private func drawOutterCircle() {
        let outterCircleView = CircleView(
            frame: CGRect(
                x: frame.size.width / 2 - outterCircleWidth / 2,
                y: frame.size.height / 2 - outterCircleHeight / 2,
                width: outterCircleWidth,
                height: outterCircleHeight),
            strokeColor: UIColor.black.cgColor,
            lineWidth: outterCircleLineWidth)
        
        addSubview(outterCircleView)
        
        // Display circle without animation
        outterCircleView.showCircle()
    }
    
    /// Draw inner circle
    private func drawInnerCircle() {
        let innerCircleView = CircleView(
            frame: CGRect(
                x: frame.size.width / 2 - innerCircleWidth / 2,
                y: frame.size.height / 2 - innerCircleHeight / 2,
                width: innerCircleWidth,
                height: innerCircleHeight),
            lineWidth: innerCircleLineWidth,
            percentageToDraw: CGFloat(circleCompleteDegrees * currentScoreValue
                / maxScoreValue))
        
        addSubview(innerCircleView)
        
        // Display circle with animation
        innerCircleView.animateCircle(duration: drawCircleAnimationDuration)
    }
    
    /// Hide previous score
    private func hidePreviousScore() {
        hideCreditScoreLabel()
        hideCreditScoreValueLabel()
        hideOutOfLabel()
    }
    
    /// Show current score
    private func showCurrentScore() {
        showCreditScoreLabel()
        showCreditScoreValueLabel()
        showOutOfLabel()
    }
    
    /// Remove previous circles
    private func removePreviousCircles() {
        for subview in subviews {
            if subview is CircleView {
                subview.removeFromSuperview()
            }
        }
    }
    
    /// Reset values
    private func resetValues() {
        timer?.invalidate()
        timer = nil
        scoreValue = 0
    }
    
    // MARK: Actions
    
    /// Update current score value label
    @objc private func updateCurrentScoreValueLabel() {
        creditScoreValueLabel.text = String(scoreValue)
        scoreValue += 1
        if scoreValue > currentScoreValue { resetValues() }
    }
}
