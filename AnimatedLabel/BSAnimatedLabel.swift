//
//  BSAnimatedLabel.swift
//  AnimatedLabel
//
//  Created by Bartosz on 11/11/2018.
//  Copyright © 2018 Bartosz Świątek. All rights reserved.
//

import UIKit

class BSAnimatedLabel: UILabel {
    
    private var displayLink : CADisplayLink?
    private(set) var isAnimating = false
    var animationDuration : TimeInterval
    var startTime : CFTimeInterval
    private var textToDraw : String?
    
    override init(frame: CGRect) {
        animationDuration = 0.0
        startTime = 0
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        animationDuration = 0.0
        startTime = 0

        super.init(coder: aDecoder)
    }
    
    func startAnimation() {
        stopAnimation()
        displayLink = CADisplayLink(target: self, selector: #selector(setNeedsDisplay(_:)))
        displayLink?.add(to: .main, forMode: .default)
        isAnimating = true
    }
    
    func stopAnimation() {
        displayLink?.invalidate()
        startTime = 0
        textToDraw = nil
        isAnimating = false
    }
  
    override func draw(_ rect: CGRect) {
        guard let displayLink = displayLink else {
            return
        }
        
        if (startTime == 0) {
            startTime = displayLink.timestamp
            return
        }
        
        if (textToDraw == nil) {
            textToDraw = self.text
        }
        
        let elapsedTime = displayLink.timestamp - startTime
        
        if (elapsedTime >= animationDuration) {
            self.text = textToDraw
            self.drawText(in: rect)
            stopAnimation()
            return
        }
        
        let percentage = elapsedTime / animationDuration
        let characterIndex = ceil(Double(textToDraw?.count ?? 0) * percentage)
        let substring = textToDraw?.prefix(Int(characterIndex))
        self.text = String(substring ?? "")
        self.drawText(in: rect)
    }
}
