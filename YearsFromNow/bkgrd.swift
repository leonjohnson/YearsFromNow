//
//  bkgrd.swift
//  LifePath
//
//  Created by Leon Johnson on 17/02/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit

class bkgrd: UIView {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        var gradientColor = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
        var gradientColor2 = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
        var gradientColor3 = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
        let gradient:CGGradient?
        let gradientLine:[CGPoint]
        
        switch APP_BACKGROUND
        {
        case APP_BACKGROUND_COLOURS.PURPLE_SUNSET:
            //// Color Declarations
            gradientColor = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
            gradientColor2 = UIColor(red: 0.933, green: 0.588, blue: 0.675, alpha: 1.000)
            gradientColor3 = UIColor(red: 0.514, green: 0.420, blue: 0.682, alpha: 1.000)
            gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: (gradientColor.cgColor, gradientColor2.cgColor, gradientColor3.cgColor) as! CFArray, locations: [0, 0.5, 1])
            gradientLine = [CGPoint(x: self.frame.midX, y: CGFloat(0.0)), CGPoint(x: self.frame.midX, y: self.frame.height)]

        case APP_BACKGROUND_COLOURS.BLUE:
            gradientColor = UIColor.blue
            gradientColor2 = UIColor.blue
            gradientColor3 = UIColor.white
            gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: (gradientColor.cgColor, gradientColor2.cgColor, gradientColor3.cgColor) as! CFArray, locations: [0, 0.5, 1])
            gradientLine = [CGPoint(x: self.frame.midX, y: CGFloat(0.0)), CGPoint(x: self.frame.midX, y: self.frame.height)]
        
        case APP_BACKGROUND_COLOURS.NEUTRAL_BLUE:
            let gradientColor = UIColor(red: 0.000, green: 0.502, blue: 1.000, alpha: 1.000)
            let gradientColor3 = UIColor(red: 0.463, green: 0.839, blue: 1.000, alpha: 1.000)
            gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: (gradientColor.cgColor, gradientColor3.cgColor) as! CFArray, locations: [0, 1])!
            gradientLine = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.maxX, y: self.frame.height)]
        
        case APP_BACKGROUND_COLOURS.CORAL_GREEN:
            let gradientColor = UIColor(red: 0.020, green: 0.729, blue: 0.710, alpha: 1.000)
            let gradientColor3 = UIColor(red: 0.478, green: 0.988, blue: 0.863, alpha: 1.000)
            let colours = [gradientColor.cgColor, gradientColor3.cgColor] as CFArray
            
            gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colours, locations: [0, 1])
            
            gradientLine = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.maxX, y: self.frame.height)]
        
        case APP_BACKGROUND_COLOURS.CORN_YELLOW:
            let gradientColor = UIColor(red: 0.984, green: 0.945, blue: 0.522, alpha: 1.000)
            let gradientColor3 = UIColor(red: 0.992, green: 0.765, blue: 0.027, alpha: 1.000)
            gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: (gradientColor3.cgColor, gradientColor.cgColor) as! CFArray, locations: [0, 1])!
            gradientLine = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.maxX, y: self.frame.height)]
            
        case APP_BACKGROUND_COLOURS.OFF_WHITE:
            let gradientColor = UIColor(red: 1.000, green: 0.973, blue: 0.941, alpha: 1.000)
            let gradientColor3 = UIColor.white
            gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: (gradientColor3.cgColor, gradientColor.cgColor) as! CFArray, locations: [0, 1])!
            gradientLine = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.maxX, y: self.frame.height)]
        }
        
        
        //// Gradient Declarations
        //let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor2.CGColor, gradientColor3.CGColor], [0, 0.5, 1])
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: self.frame)
        context?.saveGState()
        rectanglePath.addClip()
        context?.drawLinearGradient(gradient!, start: gradientLine[0], end: gradientLine[1], options: CGGradientDrawingOptions(rawValue: 0))
        context?.restoreGState()
        
        
        //// Rectangle Drawing
//        let rectanglePath = UIBezierPath(rect: CGRectMake(66, 22, 89, 83))
//        CGContextSaveGState(context)
//        rectanglePath.addClip()
//        CGContextDrawLinearGradient(context, gradient, CGPointMake(67.5, 20.5), CGPointMake(153.5, 106.5), CGGradientDrawingOptions())
//        CGContextRestoreGState(context)
    }
    
    


}
