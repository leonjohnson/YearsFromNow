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
   
    
    
    override func drawRect(rect: CGRect)
    {
        // An empty implementation adversely affects performance during animation.
        self.backgroundColor = UIColor.blackColor()
        self.alpha = 0.5
    }
    
    func fadeOut()
    {
        self.backgroundColor = UIColor.greenColor()
    }
    
    func fadeIn()
    {
        self.backgroundColor = UIColor.redColor()
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
