//
//  Tooltip.swift
//  YearsFromNow
//
//  Created by Leon Johnson on 18/09/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit

class Tooltip: UIView
{
    
    var editScreen = CreateEditGoals()
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func drawRect(rect: CGRect)
    {
        //// Rectangle Drawing
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0.8
        let rectanglePath = UIBezierPath(roundedRect: CGRectMake(0, 0, self.frame.width, self.frame.height), cornerRadius: 20)
        UIColor.whiteColor().setFill()
        rectanglePath.fill()
    }
    
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView?
    {
        let hitView = super.hitTest(point, withEvent: event)
        
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseOut, animations:
            {
                //shoot down
                self.frame.origin.y += 200
                
                //fade out
                self.alpha = 0
                
                
                
            }, completion:
            {
                finished in
                //self.frame.origin.y -= 200
                //self.removeFromSuperview()
                
                
            }
        )
        
        if hitView == self
        {
            // the user just touched the scrollview and no other subview, so behave as usual.
            return hitView
        }
        else
        {
            return hitView
            
        }
    }
}
