//
//  ViewController.swift
//  AnimatedLabel
//
//  Created by Bartosz on 11/11/2018.
//  Copyright © 2018 Bartosz Świątek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animatedLabel : BSAnimatedLabel!
    @IBOutlet weak var valueLabel : UILabel!
    @IBOutlet weak var slider : UISlider!
    
    private let defaultAnimationDuration = 2.0
    
    private let text = """
        The FIRST ORDER reigns.
        Having decimated the peaceful
        Republic, Supreme Leader Snoke
        now deploys the merciless
        legions to seize military
        control of the galaxy.
        
        Only General Leia Organa's
        band of RESISTANCE fighters
        stand against the rising
        tyranny, certain that Jedi
        Master Luke Skywalker will
        return and restore a spark of
        hope to the fight.
        
        But the Resistance has been
        exposed. As the First Order
        speeds toward the rebel base,
        the brave heroes mount a
        desperate escape....
        """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animatedLabel.animationDuration = defaultAnimationDuration
        animatedLabel.text = text
        
        slider.value = Float(defaultAnimationDuration)
        valueLabel.text = "\(defaultAnimationDuration)"
    }

    @IBAction private func startAnimation() {
        animatedLabel.text = ""
        animatedLabel.setNeedsDisplay()
        
        animatedLabel.text = text
        animatedLabel.startAnimation()
    }
    
    @IBAction private func changeDuration(sender: UISlider) {
        valueLabel.text = "\(sender.value)"
        animatedLabel.animationDuration = TimeInterval(sender.value)
    }
}

