//
//  CreateEditGoals.swift
//  YearsFromNow
//
//  Created by Leon Johnson on 14/09/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit
import RealmSwift

class CreateEditGoals: UIViewController, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate
{

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var endDatePicker : UIPickerView!
    @IBOutlet weak var deleteGoalButton : UIButton!
    @IBOutlet weak var toolTip : Tooltip!
    
    var validatedDateEntry:Bool? = Bool()
    var validatedTextEntry:Bool? = Bool()
    
    var editableGoal:Goal?
    
    
    var events : [(event: String, date: String, nsdate: NSDate)] = []
    var selectedEndMonth : String = ""
    var selecetdEndYear : String = ""
    var txt : String = ""
    
    
    var comp : NSDateComponents = NSDateComponents()
    var currentYear : Int = 0
    var currentMonth : Int = 0
    
    var currentlyDisplayedMonthIndex : Int = 0
    var currentlyDisplayedYearIndex : Int = 0
    
    var lastEndDateSelected : String = ""
    var lastEventsAlongTheWayDateSelected : String = ""
    
    var userSelectedPickerValue : Bool = false
    var initialOrLastDateSelected : [String] = []
    
    var cancelEntryFlagRaised : Bool = false
    
    var dateFormatter = NSDateFormatter()
    
    var currentEventToBeEdited : Int?
    
    var newLineExists : Bool = false
    
    
    var endDateViewExpanded = false
    var eventsAlongTheWayViewInEditMode = false
    
    var openedBefore = false
    var userIsNew:Bool?
    
    var alertController = UIAlertController?()
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Modify the button
        cancelButton.titleLabel?.font = standardFont
        cancelButton.tintColor = chosenThemeAccentColour
        
        doneButton.titleLabel?.font = systemFontBold15
        doneButton.tintColor = chosenThemeAccentColour
        
        
        // Set scrollview settings
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width,scrollView.frame.size.height);
        scrollView.bounces = false
        
        //Cursor colour
        UITextView.appearance().tintColor = chosenThemeCursorColour
        

        let nextResponder : UIResponder = notes
        nextResponder.becomeFirstResponder()
        
        comp = calendar.components(.Year, fromDate: today)
        currentYear = comp.year
        currentMonth = calendar.components(.Month, fromDate: today).month - 1
        
        
        
        
        currentlyDisplayedYearIndex = 0
        currentlyDisplayedMonthIndex = currentMonth
        
        initialOrLastDateSelected.append(months[currentMonth])
        initialOrLastDateSelected.append(String(currentYear))
        
        
        
        //eventsAlongTheWayPicker.selectRow(currentMonth, inComponent: 0, animated: false)
        //eventsAlongTheWayPicker.selectRow(currentYear, inComponent: 1, animated: false)
        
        endDate.text = months[currentMonth] + " " + String(currentYear)
        
        
        endDatePicker.dataSource = self
        endDatePicker.delegate = self
        endDatePicker.hidden = true
        
        
        
        let scrollableSize = CGSizeMake(320, self.view.frame.size.height);
        scrollView.contentSize = scrollableSize
        

        
        let endDateViewTap = UITapGestureRecognizer(target: self, action: "animateEndDateView")
        //endDateView.userInteractionEnabled = true
        self.endDateView.addGestureRecognizer(endDateViewTap)

        
        notes.font = standardFont
        notes.backgroundColor = UIColor.clearColor()
        notes.contentInset = UIEdgeInsetsMake(0, -4, 0, 0)
        notes.delegate = self
        notes.scrollRangeToVisible(NSMakeRange(0, 0))
        notes.textColor = chosenThemePlaceholderTextColour
        
        
        endDateLabel.font = labelFont
        endDateLabel.textColor = chosenThemeTextColour
        
        endDate.font = labelFont
        endDate.textColor = chosenThemeTextColour
        
        
        //rgb(113,102,169)
        
        deleteGoalButton.backgroundColor = chosenThemeButtonColour
        deleteGoalButton.setTitleColor(chosenThemeTextColour, forState: .Normal)
        deleteGoalButton.titleLabel?.font = systemFontBold15
        
        
        scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        let theTap = UITapGestureRecognizer(target: self, action: "scrollViewTapped:")
        scrollView.addGestureRecognizer(theTap)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        editableGoal = nil
    }
    
    func scrollViewTapped(recognizer: UIGestureRecognizer) {
        scrollView.endEditing(true)
    }
    
    
    
    func dismissTooltip(sender:UITapGestureRecognizer)
    {
        let subViews = scrollView.subviews
        for subview in subViews{
            if subview.isMemberOfClass(Tooltip)
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        if userIsNew ==  false
        {
            //The user knows how to change the end date at this point
            toolTip.removeFromSuperview()
        }
        if editableGoal != nil
        {
            //Show the delete button as this an edit
            deleteGoalButton.hidden = false
            
            //Set the end date to that in the database
            endDate.text = nsDateToDateString(editableGoal!.end_date)
            let month_abb = endDate.text?.componentsSeparatedByString(" ")[0]
            
            //Set the var correctly
            currentlyDisplayedMonthIndex = months.indexOf(month_abb!)!
            let displayedYear = Int((endDate.text?.componentsSeparatedByString(" ")[1])!)
            currentlyDisplayedYearIndex = displayedYear! - currentYear
        }
        else
        {
            deleteGoalButton.hidden = true
        }
        
        
        
        
        if let _ = editableGoal?.notes
        {
            notes.text = editableGoal!.notes
            doneButton.enabled = true
            
            
            let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
            newLineExists = predicate.evaluateWithObject(editableGoal!.notes)
            
            if newLineExists == false
            {
                notes.attributedText = NSAttributedString(string:editableGoal!.notes, attributes:headerAttributes)
            }
            else
            {
                let rangeOfNewLine = (editableGoal!.notes as NSString).rangeOfCharacterFromSet(NSCharacterSet.newlineCharacterSet())
                
                // HEADER
                let location = rangeOfNewLine.location
                //let length = (editableGoal!.notes.characters.count - rangeOfNewLine.location)
                let range = NSMakeRange(0, location)
                let headerAttributedString = notes.attributedText.attributedSubstringFromRange(range)
                
                // BODY
                let bodyRange = NSMakeRange(location, editableGoal!.notes.characters.count - location)
                let bodyString = (notes.text as NSString).substringWithRange(bodyRange)
                let bodyattributedString = NSAttributedString(string:bodyString, attributes:standardAttributes)
                
                
                let newAttributedString = NSMutableAttributedString()
                newAttributedString.appendAttributedString(headerAttributedString)
                newAttributedString.appendAttributedString(bodyattributedString)
                notes.attributedText = newAttributedString
                
            }
        }
        else
        {
            notes.text = String(PLACEHOLDER_TEXT)
            doneButton.enabled = false
        }
        
        notes.selectedRange = NSMakeRange(0, 0);

    }
    
    override func shouldAutorotate() -> Bool
    {
        return false
    }
    
    
    func getMonthAndYearFromNSDate(date: NSDate) -> [String]
    {
        var dateArray : [String] = Array()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM"
        
        dateArray.append(dateFormatter.stringFromDate(date))
        dateFormatter.dateFormat = "YYYY"
        dateArray.append(dateFormatter.stringFromDate(date))
        
        return dateArray
    }
    
    
    
    
    @IBAction func cancelInsert()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
    
    /*
    DATE CONVERSION METHODS
    */
    func dateStringToNSDate(dateStringParameter:String) ->NSDate
    {
        // 'Sep 2015' to NSDate
        var dateString = dateStringParameter
        dateString  = dateString.stringByReplacingOccurrencesOfString(" ", withString: " 01, ")
        //dateString.insert(" 01", atIndex: dateString.startIndex.advancedBy(3))
        //dateString.splice(" 01,", atIndex: dateString.startIndex.advancedBy(3))
        let dateFormatter2 = NSDateFormatter()
        //http://stackoverflow.com/questions/28382482/ios-app-crashes-on-phone-but-works-fine-on-simulator
        dateFormatter2.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        dateFormatter2.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter2.timeStyle = NSDateFormatterStyle.NoStyle
        let thedate = dateFormatter2.dateFromString(dateString)
        return thedate!
    }
    
    func nsDateToDateString(date:NSDate) ->String
    {
        // NSDate to 'Sep 2015'
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        //http://stackoverflow.com/questions/28382482/ios-app-crashes-on-phone-but-works-fine-on-simulator
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        var formattedDateString = dateFormatter.stringFromDate(date)
        formattedDateString.removeAtIndex(formattedDateString.startIndex.advancedBy(3))
        formattedDateString.removeAtIndex(formattedDateString.startIndex.advancedBy(3))
        formattedDateString.removeAtIndex(formattedDateString.startIndex.advancedBy(3))
        return formattedDateString.uppercaseString
    }
    /*
    DATE CONVERSION METHODS
    */
    
    
    @IBAction func closeEditScreen(sender:AnyObject)
    {
        validateGoalEntryDate()
    }
    
    func validateGoalEntryDate()
    {

        // 1. The user has attempted to create a goal for the current month
        //print("a. \(currentlyDisplayedMonthIndex) b. \(currentlyDisplayedYearIndex)")
        
        if (currentlyDisplayedMonthIndex == currentMonth) && (currentlyDisplayedYearIndex == 0)
        {
            alertController = UIAlertController(title: "Are you sure?", message: "Did you mean to select an End Date for this month?", preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (_) -> Void in
                
                if self.validateGoalEntryText() == true
                {
                    self.saveGoal()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            
            let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) { (_) -> Void in
                
               // print("hitting false")
            }
            
            alertController?.addAction(yesAction)
            alertController?.addAction(noAction)
            
            self.presentViewController(alertController!, animated: true, completion: nil)
        }
        else
        {
            if self.validateGoalEntryText() == true
            {
                self.saveGoal()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    
    
    func validateGoalEntryText()->Bool
    {
        // 2. If notes field is empty
        if (notes.text.isEmpty == true) || (notes.text == (PLACEHOLDER_TEXT))
        {
            if notes.text == (PLACEHOLDER_TEXT)
            {
                //print("THEY ARE EQUAL")
            }
            alertController = UIAlertController(title: "Describe your goal", message: "Please describe your goal before attempting to save it", preferredStyle: .Alert)
            let ok  = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController?.addAction(ok)
            self.presentViewController(alertController!, animated: true, completion: nil)
            return false
        }
            
            
        else
        {
            return true
            
        }
    }
    
    
    
    func saveGoal()
    {
        if editableGoal != nil
        {

            do {
                //print("UPDATING RECORD")
                let realm = try Realm()
                
                try realm.write
                    {
                        self.notes.text = self.notes.text.componentsSeparatedByString("*").joinWithSeparator("#")
                        self.editableGoal?.notes = self.notes.text
                        self.editableGoal?.end_date = self.dateStringToNSDate(self.endDate.text!)
                }
            }
            catch
            {
                print(error)
            }
            
        }
        else
        {
            //print("CREATING A NEW RECORD")
            let goal = Goal()
            goal.notes = self.notes.text
            goal.start_date = NSDate()
            
            goal.end_date = dateStringToNSDate(endDate.text!)
            
            
            do {
                let realm = try Realm()
                try realm.write
                    {
                        realm.add(goal)
                }
            }
            catch
            {
                print(error)
            }
        }
    }
    
    
    
    
    @IBAction func deleteGoal()
    {
        if editableGoal != nil
        {
            do
            {
                let realm = try Realm()
                try realm.write {
                    realm.delete(self.editableGoal!)
                }
            }
            catch
            {
                print(error)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // MARK: - Notes Field methods
    func getNotesTitle(thenotes:String) -> NSAttributedString
    {
        var notesTitle : NSMutableAttributedString = NSMutableAttributedString()
        let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
        newLineExists = predicate.evaluateWithObject(thenotes)
        if newLineExists == true
        {
            // HEADER
            let rangeOfNewLine = (notes.text as NSString).rangeOfCharacterFromSet(NSCharacterSet.newlineCharacterSet())
            let location = rangeOfNewLine.location
            //let length = (notes.text.characters.count - rangeOfNewLine.location)
            let range = NSMakeRange(0, location)
            let substring = (thenotes as NSString).substringWithRange(range)
            notesTitle = NSMutableAttributedString(string:substring, attributes:headerAttributes)
        }
        else
        {
            notesTitle = NSMutableAttributedString(string:thenotes, attributes:headerAttributes)
        }
        
        return notesTitle as NSAttributedString
    }
    
    

    
    @IBAction func animateEndDateView()
    {
                
        //never show tooltip again
        showEndDateTooltip = false
        
        notes.resignFirstResponder()
        notes.textColor = chosenThemePlaceholderTextColour
        //print("closing == \(openedBefore.description)")
        var distanceToAnimateView : CGFloat = 0.00
        if endDateViewExpanded == true // if we're already in edit mode...
        {
            distanceToAnimateView = -200.00
        }
        else
        {
            distanceToAnimateView = 200.00
        }
        
        var monthToShow = currentMonth
        var yearToShow = 0
        
        if let _ = editableGoal
        {
            monthToShow = calendar.components(.Month, fromDate:editableGoal!.end_date).month-1
            yearToShow = calendar.components(.Year, fromDate:editableGoal!.end_date).year - currentYear
            
        }
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations:
            {
                self.endDateView.frame.size.height += distanceToAnimateView
                
                if self.openedBefore == false
                {
                    // scroll to the correct month. The current year is the first option by design.
                    self.endDatePicker.selectRow(monthToShow, inComponent: 0, animated: false)
                    self.endDatePicker.selectRow(yearToShow, inComponent: 1, animated: false)
                }
                
                
            }, completion:
            {
                finished in
                self.endDateViewExpanded = !self.endDateViewExpanded
                self.endDatePicker.hidden = !self.endDatePicker.hidden
            }
        )
        
       openedBefore = true
    }
    
    

    

    // MARK: - TEXTFIELD / TEXTVIEW DELEGATE METHODS
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
       return true
    }
    
    
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        //scrollView.setContentOffset(CGPointMake(0, 50), animated: true)
        //println("pushed up")
        //eventsAlongTheWayPicker.hidden = true
    }
    
    

    
    func textFieldDidEndEditing(textField: UITextField)
    {
        txt = textField.text!
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        
    
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if textView.text.isEmpty
        {
            textView.text == "placeholder text here..."
        }
        else
        {
            textView.textColor = UIColor.blackColor()
        }
    }
    
    
    
    func textViewDidChange(textView: UITextView)
    {
        
        
        
        
        let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
        newLineExists = predicate.evaluateWithObject(notes.text)
        
        if newLineExists == false
        {
            notes.attributedText = NSAttributedString(string:notes.text, attributes:headerAttributes)
            //print("applied the header attributes")
            if textView.text.length == 0
            {
                textView.text = PLACEHOLDER_TEXT
                textView.font = standardFont
                textView.textColor = chosenThemePlaceholderTextColour
                doneButton.enabled = false
            }
        }
        else
        {
            let rangeOfNewLine = (notes.text as NSString).rangeOfCharacterFromSet(NSCharacterSet.newlineCharacterSet())
            
            // HEADER
            let location = rangeOfNewLine.location
            //let length = (notes.text.characters.count - rangeOfNewLine.location)
            let range = NSMakeRange(0, location)
            //println("range of header text: \(range).")
            let headerAttributedString = notes.attributedText.attributedSubstringFromRange(range)
            
            // BODY
            let bodyRange = NSMakeRange(location, notes.text.characters.count - location)
            
            //println("range of standard text: \(bodyRange).")
            
            let bodyString = (notes.text as NSString).substringWithRange(bodyRange)
            let bodyattributedString = NSAttributedString(string:bodyString, attributes:standardAttributes)
            
            //println("bodyattributedString: \(bodyattributedString). headerAttributedString: \(headerAttributedString)")
            
            let newAttributedString = NSMutableAttributedString()
            newAttributedString.appendAttributedString(headerAttributedString)
            newAttributedString.appendAttributedString(bodyattributedString)
            notes.attributedText = newAttributedString
            
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        // The text view calls this method whenever the user types a new character or deletes an existing character.
        
        //let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
        //newLineExists = predicate.evaluateWithObject(notes.text)
        //println("Match = newLineExists? : \(newLineExists) and range of: \(range) and text of: \(text)")
        
        
        
        if textView.text == PLACEHOLDER_TEXT
        {
            textView.text = "";
            doneButton.enabled = true
        }
        return true
    }
    
    



}
