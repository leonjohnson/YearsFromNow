//
//  PickerDelegate.swift
//  LifePath
//
//  Created by Leon Johnson on 05/03/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit

extension CreateEditGoals: UIPickerViewDelegate
{
    // MARK - UIPicker Data source and delegate
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return 12
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if component == 0
        {
            return months[row]
        }
        return String(currentYear+row)
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //
        
        var textToDisplay:String = ""
        
        
        if component == 0
        {
            let selectedRowForMonth = months[row]
            currentlyDisplayedMonthIndex = row
            textToDisplay = selectedRowForMonth + " " + String(currentYear + currentlyDisplayedYearIndex)
        }
        if component == 1
        {
            let selectedRowForYear = String(currentYear+row)
            currentlyDisplayedYearIndex = row
            textToDisplay = months[currentlyDisplayedMonthIndex] + " " + selectedRowForYear
            
        }
        
        //endDate.text
        if pickerView == endDatePicker
        {
            endDate.text = textToDisplay
            lastEventsAlongTheWayDateSelected = textToDisplay
        }
        
        
        // validate the selection
        if currentlyDisplayedYearIndex == 0 && currentlyDisplayedMonthIndex < currentMonth
        {
            pickerView.selectRow(currentMonth, inComponent: 0, animated: true)
        }
        
    }
    
    
}
