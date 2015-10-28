//
//  CreateEditScrollViewDelegate.swift
//  YearsFromNow
//
//  Created by Leon Johnson on 18/09/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit

extension CreateEditGoals : UIScrollViewDelegate
    
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        notes.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print("touched scroll view")
    }
}
