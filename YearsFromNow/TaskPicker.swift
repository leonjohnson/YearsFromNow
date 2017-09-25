//
//  TaskPicker.swift
//  YearsFromNow
//
//  Created by toobler on 22/09/17.
//  Copyright © 2017 Leon Johnson. All rights reserved.
//

import UIKit
import RealmSwift
class TaskPicker: UIButton,UIPickerViewDelegate,UIPickerViewDataSource {

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var completionBlock: ((Goal?) -> Void)? = nil

    var goals : Results < Goal >? = nil;

    var selectedIndex  = 0;

    var currentTask : Goal? = nil;





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
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(TaskPicker.selectedItem))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputView = endDatePicker;
        inputAccessoryView = keyboardToolbar;

        loadTasks();

    }
    func loadTasks(){
        do{
        let realm = try Realm()
         goals = realm.objects(Goal.self)
        }catch{

        }
    }

    func selectedItem(){

        resignFirstResponder()
        if((goals == nil || goals?.count == 0)){
            if let completionBlock = self.completionBlock {
                completionBlock(nil);
            }
            return ;
            }
        if let completionBlock = self.completionBlock {
            completionBlock((goals?[selectedIndex])!);
        }
        text = ((goals?[selectedIndex])!.notes);
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
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {

        if((goals == nil)){
            return 0;
        }
        return goals!.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if component == 0
        {
            let goal:Goal = goals![row]
            return goal.notes;
        }
            return "";
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedIndex = row;
    }
}
