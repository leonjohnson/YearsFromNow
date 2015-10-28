//
//  CreateEditScrollView.swift
//  YearsFromNow
//
//  Created by Leon Johnson on 18/10/2015.
//  Copyright © 2015 Leon Johnson. All rights reserved.
//

import UIKit

class CreateEditScrollView: UIScrollView
{

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView?
    {
        let hitView = super.hitTest(point, withEvent: event)
        
        
        if hitView == self
        {
            // the user just touched the scrollview and no other subview, so behave as usual.
            print("just touched myself")
            return hitView
        }
        else
        {
            print("just touched outside of myself")
            return hitView
            
        }
    }

}
