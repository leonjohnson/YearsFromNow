//
//  PickerButton.swift
//  YearsFromNow
//
//  Created by toobler on 22/09/17.
//  Copyright © 2017 Leon Johnson. All rights reserved.
//

import UIKit

class PickerButton: UIButton,UIPickerViewDelegate,UIPickerViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var completionBlock: ((String , Bool) -> Void)? = nil

    var startYear:Int = 0;
    var startMonth:Int = 0;
    var currentlyDisplayedYearIndex:Int = 0;
    var currentlyDisplayedMonthIndex:Int = 0;
   


    // This holds the assigned input view (superclass property is readonly)
    private var customInputView: UIPickerView?
    // This holds the assigned input view (superclass property is readonly)
    private var customInputAccessoryView: UIView?

    func createInputView(){

        let endDatePicker = UIPickerView();
        endDatePicker.dataSource = self
        endDatePicker.delegate = self

            let keyboardToolbar = UIToolbar()
            keyboardToolbar.sizeToFit()
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerButton.clickedDate))
            keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputView = endDatePicker;
        inputAccessoryView = keyboardToolbar;
    }
    func clickedDate(status :Bool ){
        // validate the selection
        if currentlyDisplayedYearIndex == 0 && currentlyDisplayedMonthIndex < startMonth
        {
            customInputView?.selectRow(startMonth, inComponent: 0, animated: false)
            currentlyDisplayedMonthIndex = startMonth;
        }

        let selectedRowForMonth = months[currentlyDisplayedMonthIndex]
        text = selectedRowForMonth + " " + String(startYear + currentlyDisplayedYearIndex)
        self.resignFirstResponder();
        if let completionBlock = self.completionBlock {
            completionBlock(text , status);
        }
    }
    func selectedDate(){
        select()
        clickedDate(status: false)

    }

    // We override the superclass property as computed, and actually
    // store into customInputView:
    override var inputView: UIPickerView? {
        get {
            return customInputView
        }
        set (newValue) {
            customInputView = newValue
        }
    }

    override var inputAccessoryView: UIView? {
        get {
            return customInputAccessoryView
        }
        set (newValue) {
            customInputAccessoryView = newValue
        }
    }


    var text:String{
        get {
            return title(for: .normal)!
        }
        set (newValue) {
            setTitle(newValue, for: .normal)
        }
    }

    // Must be able to become first responder in order to
    // get input view to be displayed:
    override var canBecomeFirstResponder: Bool {
        return true
    }

    // Setup becoming first responder on tap:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.addTarget(self, action: #selector(PickerButton.tap(_:)), for: .touchDown)

    }
    @IBAction func tap(_ sender: UIButton) {
        self.becomeFirstResponder()

    }

    func select(){
        customInputView?.selectRow(currentlyDisplayedMonthIndex, inComponent: 0, animated: true)
        customInputView?.selectRow(currentlyDisplayedYearIndex, inComponent: 1, animated: true)
    }

    // MARK - UIPicker Data source and delegate


    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {

        return 12

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if component == 0
        {
            return months[row]
        }
        return String(startYear+row)
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if component == 0
        {
            currentlyDisplayedMonthIndex = row
        }
        if component == 1
        {
            currentlyDisplayedYearIndex = row
        }


        validateDate(pickerView: pickerView);

//        // validate the selection
//        if currentlyDisplayedYearIndex == 0 && currentlyDisplayedMonthIndex < startMonth
//        {
//            pickerView.selectRow(startMonth, inComponent: 0, animated: true)
//            currentlyDisplayedMonthIndex = startMonth;
//        }

    }

    func validateDate(pickerView:UIPickerView){
        let  selectedDate =  months[currentlyDisplayedMonthIndex] + " " + String(startYear + currentlyDisplayedYearIndex)

        let  startDate =  months[startMonth] + " " + String(startYear)

        if(CreateEditGoals.dateStringToNSDate(startDate)>CreateEditGoals.dateStringToNSDate(selectedDate)){
            pickerView.selectRow(startMonth, inComponent: 0, animated: true)
            pickerView.selectRow(startYear, inComponent: 1, animated: true)
        }
    }
}
