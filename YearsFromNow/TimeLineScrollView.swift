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
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.move(to: CGPoint(x: dateLabelLength, y: 0))
        context?.addLine(to: CGPoint(x: dateLabelLength, y: self.frame.size.height))
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.setStrokeColor(red: 1.0, green: 0.5, blue: 0.7, alpha: 1.0)
        context?.drawPath(using: .stroke)
        
    }
    

}
