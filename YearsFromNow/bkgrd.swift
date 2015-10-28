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
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        var gradientColor = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
        var gradientColor2 = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
        var gradientColor3 = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
        let gradient:CGGradientRef?
        let gradientLine:[CGPoint]
        
        switch APP_BACKGROUND
        {
        case APP_BACKGROUND_COLOURS.PURPLE_SUNSET:
            //// Color Declarations
            gradientColor = UIColor(red: 0.941, green: 0.702, blue: 0.620, alpha: 1.000)
            gradientColor2 = UIColor(red: 0.933, green: 0.588, blue: 0.675, alpha: 1.000)
            gradientColor3 = UIColor(red: 0.514, green: 0.420, blue: 0.682, alpha: 1.000)
            gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor2.CGColor, gradientColor3.CGColor], [0, 0.5, 1])
            gradientLine = [CGPointMake(self.frame.midX, CGFloat(0.0)), CGPointMake(self.frame.midX, self.frame.height)]

        case APP_BACKGROUND_COLOURS.BLUE:
            gradientColor = UIColor.blueColor()
            gradientColor2 = UIColor.blueColor()
            gradientColor3 = UIColor.whiteColor()
            gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor2.CGColor, gradientColor3.CGColor], [0, 0.5, 1])
            gradientLine = [CGPointMake(self.frame.midX, CGFloat(0.0)), CGPointMake(self.frame.midX, self.frame.height)]
        
        case APP_BACKGROUND_COLOURS.NEUTRAL_BLUE:
            let gradientColor = UIColor(red: 0.000, green: 0.502, blue: 1.000, alpha: 1.000)
            let gradientColor3 = UIColor(red: 0.463, green: 0.839, blue: 1.000, alpha: 1.000)
            gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor3.CGColor], [0, 1])!
            gradientLine = [CGPointMake(0, 0), CGPointMake(self.frame.maxX, self.frame.height)]
        
        case APP_BACKGROUND_COLOURS.CORAL_GREEN:
            let gradientColor = UIColor(red: 0.020, green: 0.729, blue: 0.710, alpha: 1.000)
            let gradientColor3 = UIColor(red: 0.478, green: 0.988, blue: 0.863, alpha: 1.000)
            gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor3.CGColor], [0, 1])!
            gradientLine = [CGPointMake(0, 0), CGPointMake(self.frame.maxX, self.frame.height)]
        
        case APP_BACKGROUND_COLOURS.CORN_YELLOW:
            let gradientColor = UIColor(red: 0.984, green: 0.945, blue: 0.522, alpha: 1.000)
            let gradientColor3 = UIColor(red: 0.992, green: 0.765, blue: 0.027, alpha: 1.000)
            gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor3.CGColor, gradientColor.CGColor], [0, 1])!
            gradientLine = [CGPointMake(0, 0), CGPointMake(self.frame.maxX, self.frame.height)]
            
        case APP_BACKGROUND_COLOURS.OFF_WHITE:
            let gradientColor = UIColor(red: 1.000, green: 0.973, blue: 0.941, alpha: 1.000)
            let gradientColor3 = UIColor.whiteColor()
            gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor3.CGColor, gradientColor.CGColor], [0, 1])!
            gradientLine = [CGPointMake(0, 0), CGPointMake(self.frame.maxX, self.frame.height)]
        }
        
        
        //// Gradient Declarations
        //let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor2.CGColor, gradientColor3.CGColor], [0, 0.5, 1])
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: self.frame)
        CGContextSaveGState(context)
        rectanglePath.addClip()
        CGContextDrawLinearGradient(context, gradient, gradientLine[0], gradientLine[1], CGGradientDrawingOptions(rawValue: 0))
        CGContextRestoreGState(context)
        
        
        //// Rectangle Drawing
//        let rectanglePath = UIBezierPath(rect: CGRectMake(66, 22, 89, 83))
//        CGContextSaveGState(context)
//        rectanglePath.addClip()
//        CGContextDrawLinearGradient(context, gradient, CGPointMake(67.5, 20.5), CGPointMake(153.5, 106.5), CGGradientDrawingOptions())
//        CGContextRestoreGState(context)
    }
    
    


}
