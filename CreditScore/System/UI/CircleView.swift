//
//  CircleView.swift
//  CreditScore
//
//  Created by Jordi Gámez on 10/07/2019.
//  Copyright © 2019 JordiGamez. All rights reserved.
//

import UIKit

/// CircleView
class CircleView: UIView {
    
    // MARK: Private constants
    
    private let initialDegree: CGFloat = 90
    private let strokeEndKey = "strokeEnd"
    private let animateCircleKey = "animateCircle"
    
    // MARK: Private variables
    
    private var strokeColor = UIColor.clear.cgColor
    private var lineWidth: CGFloat = 0
    private var percentageToDraw: CGFloat = 0
    private var circleShapeLayer: CAShapeLayer!
    
    // MARK: Initializers
    
    init(frame: CGRect, strokeColor: CGColor, lineWidth: CGFloat, percentageToDraw: CGFloat = 360) {
        super.init(frame: frame)
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.percentageToDraw = percentageToDraw
        setBackgroundColor()
        addCircleShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    /// Set background color
    private func setBackgroundColor() {
        backgroundColor = UIColor.clear
    }
    
    /// Add circle shape layer
    private func addCircleShapeLayer() {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0,
                               y: frame.size.height / 2.0),
            radius: (frame.size.width - 10)/2,
            startAngle: (initialDegree * -1.0).degreesToRadians(),
            endAngle: (percentageToDraw - initialDegree).degreesToRadians(),
            clockwise: true)
        circleShapeLayer = CAShapeLayer()
        circleShapeLayer.path = circlePath.cgPath
        circleShapeLayer.fillColor = UIColor.clear.cgColor
        circleShapeLayer.strokeColor = strokeColor
        circleShapeLayer.lineWidth = lineWidth
        circleShapeLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleShapeLayer)
    }
    
    // MARK: Public methods
    
    /// Animate circle fill
    ///
    /// - Parameter duration: TimeInterval
    func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: strokeEndKey)
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        showCircle()
        
        circleShapeLayer.add(animation, forKey: animateCircleKey)
    }
    
    /// Display circle
    func showCircle() {
        circleShapeLayer.strokeEnd = 1.0
    }
}
