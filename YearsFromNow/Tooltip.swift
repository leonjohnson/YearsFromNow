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
    
    override func draw(_ rect: CGRect)
    {
        //// Rectangle Drawing
        self.backgroundColor = UIColor.clear
        self.alpha = 0.8
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), cornerRadius: 20)
        UIColor.white.setFill()
        rectanglePath.fill()
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?
    {
        let hitView = super.hitTest(point, with: event)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations:
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
