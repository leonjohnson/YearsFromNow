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
    typealias CompletionBlock = (NSString?) -> Void

    var currentYear:Int = 0;
    var currentMonth:Int = 0;
    var currentlyDisplayedYearIndex:Int = 0;
    var currentlyDisplayedMonthIndex:Int = 0;
    var onCompletion: UIButton? ;


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
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerButton.selectedDate))
            keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputView = endDatePicker;
        inputAccessoryView = keyboardToolbar;

    }

    func selectedDate(){

        // validate the selection
        if currentlyDisplayedYearIndex == 0 && currentlyDisplayedMonthIndex < currentMonth
        {
            customInputView?.selectRow(currentMonth, inComponent: 0, animated: false)
            currentlyDisplayedMonthIndex = currentMonth;
        }

         let selectedRowForMonth = months[currentlyDisplayedMonthIndex]
         text = selectedRowForMonth + " " + String(currentYear + currentlyDisplayedYearIndex)
        self.resignFirstResponder();
        if(onCompletion != nil){
            onCompletion?.setTitle(text, for: .normal)
        }

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
        return String(currentYear+row)
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

        // validate the selection
        if currentlyDisplayedYearIndex == 0 && currentlyDisplayedMonthIndex < currentMonth
        {
            pickerView.selectRow(currentMonth, inComponent: 0, animated: true)
            currentlyDisplayedMonthIndex = currentMonth;
        }

    }
}
