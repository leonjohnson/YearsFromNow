//
//  TimeLineScrollView.swift
//  YearsFromNow
//
//  Created by Leon Johnson on 25/09/2015.
//  Copyright © 2015 Leon Johnson. All rights reserved.
//

import UIKit

class TimeLineScrollView: UIScrollView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        print("showing")
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, dateLabelLength, 0)
        CGContextAddLineToPoint(context, dateLabelLength, self.frame.size.height)
        CGContextClosePath(context)
        CGContextSetLineWidth(context, 1.0)
        CGContextSetRGBStrokeColor(context, 1.0, 0.5, 0.7, 1.0)
        CGContextDrawPath(context, .Stroke)
        
    }
    

}
