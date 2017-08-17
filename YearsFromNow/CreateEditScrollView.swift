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

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?
    {
        let hitView = super.hitTest(point, with: event)
        
        
        if hitView == self
        {
            // the user just touched the scrollview and no other subview, so behave as usual.
            #if DEBUG
                print("just touched myself")
            #endif
            
            return hitView
        }
        else
        {
            #if DEBUG
                print("just touched outside of myself")
            #endif
            
            return hitView
            
        }
    }

}
