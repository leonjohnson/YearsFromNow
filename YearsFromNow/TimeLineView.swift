//
//  TimeLineView.swift
//  LifePath
//
//  Created by Leon Johnson on 15/03/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit

class TimeLineView: UIView {
    
    var goalIndex : Int = 0
    var goal : Goal?
    // looking into 'resting touches'
   
    
    
    override func draw(_ rect: CGRect)
    {
        // An empty implementation adversely affects performance during animation.
        //self.backgroundColor = UIColor.black
        //self.alpha = 0.5
        
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let gradientColor = UIColor(red: 0.789, green: 1.000, blue: 0.983, alpha: 1.000)
        
        //// Gradient Declarations
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [UIColor.white.cgColor, gradientColor.cgColor] as CFArray, locations: [0, 1])!
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                             y: 0,
                                                             width: self.frame.width,
                                                             height: self.frame.height),
                                         cornerRadius: 19.5)
        context.saveGState()
        rectanglePath.addClip()
        //
        context.drawLinearGradient(gradient,
                                   start: CGPoint(x: self.frame.width/2, y: 0), end: CGPoint(x: self.frame.width/2, y: self.frame.height), options: CGGradientDrawingOptions())
        context.saveGState()
        
    }
    
    func fadeOut()
    {
        self.backgroundColor = UIColor.green
    }
    
    func fadeIn()
    {
        self.backgroundColor = UIColor.red
        self.alpha = 0.5
    }
    
    
    
    /*
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool
    {
        println("just touched a timeline, and now passing it on...")
        return false

    }
    */
    
    
}
