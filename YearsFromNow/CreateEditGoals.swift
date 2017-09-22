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


    @IBOutlet weak var endDateField: PickerButton!
    @IBOutlet weak var startDatePicker: PickerButton!

    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var deleteGoalButton : UIButton!
    @IBOutlet weak var toolTip : Tooltip!

    
    var validatedDateEntry:Bool? = Bool()
    var validatedTextEntry:Bool? = Bool()
    
    var editableGoal:Goal?


    
    
    var events : [(event: String, date: String, nsdate: Date)] = []
    var selectedEndMonth : String = ""
    var selecetdEndYear : String = ""
    var txt : String = ""
    
    
    var comp : DateComponents = DateComponents()

    //var currentYear : Int = 0
    //var currentMonth : Int = 0
    //var currentlyDisplayedMonthIndex : Int = 0
    //  var currentlyDisplayedYearIndex : Int = 0
    
    var lastEndDateSelected : String = ""
    var lastEventsAlongTheWayDateSelected : String = ""
    
    var userSelectedPickerValue : Bool = false
    var initialOrLastDateSelected : [String] = []
    
    var cancelEntryFlagRaised : Bool = false
    
    var dateFormatter = DateFormatter()
    
    var currentEventToBeEdited : Int?
    
    var newLineExists : Bool = false
    
    
    var endDateViewExpanded = false
    var eventsAlongTheWayViewInEditMode = false
    
    var openedBefore = false
    var userIsNew:Bool?
    
    var alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)


    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Modify the button
        cancelButton.titleLabel?.font = standardFont
        cancelButton.tintColor = chosenThemeAccentColour
        
        doneButton.titleLabel?.font = systemFontBold15
        doneButton.tintColor = chosenThemeAccentColour
        
        
        // Set scrollview settings
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width,height: scrollView.frame.size.height);
        scrollView.bounces = false
        
        //Cursor colour
        UITextView.appearance().tintColor = chosenThemeCursorColour

        let nextResponder : UIResponder = notes
        nextResponder.becomeFirstResponder()
        
        comp = (calendar as NSCalendar).components(.year, from: today)
        endDateField.currentYear = comp.year!
        endDateField.currentMonth = (calendar as NSCalendar).components(.month, from: today).month! - 1

        startDatePicker.currentYear = comp.year!
        startDatePicker.currentMonth = endDateField.currentMonth
        
        

        initialOrLastDateSelected.append(months[endDateField.currentMonth])
        initialOrLastDateSelected.append(String(endDateField.currentYear))


        notes.font = standardFont
        notes.backgroundColor = UIColor.clear
        notes.contentInset = UIEdgeInsetsMake(0, -4, 0, 0)
        notes.delegate = self
        notes.scrollRangeToVisible(NSMakeRange(0, 0))
        notes.textColor = chosenThemePlaceholderTextColour
        
        
        // endDateLabel.font = labelFont
        // endDateLabel.textColor = chosenThemeTextColour
        
        // endDate.font = labelFont
        // endDate.textColor = chosenThemeTextColour

        //rgb(113,102,169)
        
        deleteGoalButton.backgroundColor = chosenThemeButtonColour
        deleteGoalButton.setTitleColor(chosenThemeTextColour, for: UIControlState())
        deleteGoalButton.titleLabel?.font = systemFontBold15
        endDateField.selectedDate();
        endDateField.createInputView();

        startDatePicker.createInputView();
        startDatePicker.onCompletion = startDateButton



    }


   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillDisappear(_ animated: Bool)
    {
        editableGoal = nil
    }


    
    func dismissTooltip(_ sender:UITapGestureRecognizer)
    {
        let subViews = scrollView.subviews
        for subview in subViews{
            if subview.isMember(of: Tooltip.self)
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        if userIsNew ==  false
        {
            //The user knows how to change the end date at this point
            // toolTip.removeFromSuperview()
        }
        if editableGoal != nil
        {
            //Show the delete button as this an edit
            deleteGoalButton.isHidden = false
            let datestring  = nsDateToDateString(editableGoal!.end_date as Date)
            let month_abb = datestring.components(separatedBy: " ")[0]
            
            //Set the var correctly
            endDateField.currentlyDisplayedMonthIndex = months.index(of: month_abb)!
            let displayedYear = Int((datestring.components(separatedBy: " ")[1]))
            endDateField.currentlyDisplayedYearIndex = displayedYear! - endDateField.currentYear
        }
        else
        {
                deleteGoalButton.isHidden = true
        }
        
        
        
        
        if let _ = editableGoal?.notes
        {
            notes.text = editableGoal!.notes
            doneButton.isEnabled = true
            
            
            let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
            newLineExists = predicate.evaluate(with: editableGoal!.notes)
            
            if newLineExists == false
            {
                notes.attributedText = NSAttributedString(string:editableGoal!.notes, attributes:headerAttributes)
            }
            else
            {
                let rangeOfNewLine = (editableGoal!.notes as NSString).rangeOfCharacter(from: CharacterSet.newlines)
                
                // HEADER
                let location = rangeOfNewLine.location
                //let length = (editableGoal!.notes.characters.count - rangeOfNewLine.location)
                let range = NSMakeRange(0, location)
                let headerAttributedString = notes.attributedText.attributedSubstring(from: range)
                
                // BODY
                let bodyRange = NSMakeRange(location, editableGoal!.notes.characters.count - location)
                let bodyString = (notes.text as NSString).substring(with: bodyRange)
                let bodyattributedString = NSAttributedString(string:bodyString, attributes:standardAttributes)
                
                
                let newAttributedString = NSMutableAttributedString()
                newAttributedString.append(headerAttributedString)
                newAttributedString.append(bodyattributedString)
                notes.attributedText = newAttributedString
                
            }
        }
        else
        {
            notes.text = String(PLACEHOLDER_TEXT)
            doneButton.isEnabled = false
        }
        
        notes.selectedRange = NSMakeRange(0, 0);

    }
    
    override var shouldAutorotate : Bool
    {
        return false
    }
    
    
    func getMonthAndYearFromNSDate(_ date: Date) -> [String]
    {
        var dateArray : [String] = Array()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        
        dateArray.append(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "YYYY"
        dateArray.append(dateFormatter.string(from: date))
        
        return dateArray
    }
    
    
    
    
    @IBAction func cancelInsert()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    
    /*
    DATE CONVERSION METHODS
    */
    func dateStringToNSDate(_ dateStringParameter:String) ->Date
    {
        // 'Sep 2015' to NSDate
        var dateString = dateStringParameter
        dateString  = dateString.replacingOccurrences(of: " ", with: " 01, ")
        //dateString.insert(" 01", atIndex: dateString.startIndex.advancedBy(3))
        //dateString.splice(" 01,", atIndex: dateString.startIndex.advancedBy(3))
        let dateFormatter2 = DateFormatter()
        //http://stackoverflow.com/questions/28382482/ios-app-crashes-on-phone-but-works-fine-on-simulator
        dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter2.dateStyle = DateFormatter.Style.medium
        dateFormatter2.timeStyle = DateFormatter.Style.none
        let thedate = dateFormatter2.date(from: dateString)
        return thedate!
    }
    
    func nsDateToDateString(_ date:Date) ->String
    {
        // NSDate to 'Sep 2015'
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        //http://stackoverflow.com/questions/28382482/ios-app-crashes-on-phone-but-works-fine-on-simulator
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        var formattedDateString = dateFormatter.string(from: date)
        formattedDateString.remove(at: formattedDateString.characters.index(formattedDateString.startIndex, offsetBy: 3))
        formattedDateString.remove(at: formattedDateString.characters.index(formattedDateString.startIndex, offsetBy: 3))
        formattedDateString.remove(at: formattedDateString.characters.index(formattedDateString.startIndex, offsetBy: 3))
        return formattedDateString.uppercased()
    }
    /*
    DATE CONVERSION METHODS
    */
    
    
    @IBAction func closeEditScreen(_ sender:AnyObject)
    {
        validateGoalEntryDate()
    }
    
    func validateGoalEntryDate()
    {

        // 1. The user has attempted to create a goal for the current month
        //print("a. \(currentlyDisplayedMonthIndex) b. \(currentlyDisplayedYearIndex)")

        if (endDateField.currentlyDisplayedMonthIndex == endDateField.currentMonth) && (endDateField.currentlyDisplayedYearIndex == 0)
        {
            alertController = UIAlertController(title: "Are you sure?", message: "Did you mean to select an End Date for this month?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (_) -> Void in
                
                if self.validateGoalEntryText() == true
                {
                    self.saveGoal()
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default) { (_) -> Void in
                
               // print("hitting false")
            }
            
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            if self.validateGoalEntryText() == true
            {
                self.saveGoal()
                self.dismiss(animated: true, completion: nil)
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
            alertController = UIAlertController(title: "Describe your goal", message: "Please describe your goal before attempting to save it", preferredStyle: .alert)
            let ok  = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
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
                        self.notes.text = self.notes.text.components(separatedBy: ("*")).joined()
                        //self.notes.text = self.notes.text.componentsSeparatedByString("*").joinWithSeparator("#")
                        self.editableGoal?.notes = self.notes.text
                        self.editableGoal?.end_date = self.dateStringToNSDate(self.endDateField.text)
                }
            }
            catch
            {
                #if DEBUG
                    print(error)
                #endif
                
            }
            
        }
        else
        {
            //print("CREATING A NEW RECORD")
            let goal = Goal()
            goal.notes = self.notes.text
            goal.start_date = Date()
            
            goal.end_date = dateStringToNSDate(self.endDateField.text)
            
            
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
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Notes Field methods
    func getNotesTitle(_ thenotes:String) -> NSAttributedString
    {
        var notesTitle : NSMutableAttributedString = NSMutableAttributedString()
        let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
        newLineExists = predicate.evaluate(with: thenotes)
        if newLineExists == true
        {
            // HEADER
            let rangeOfNewLine = (notes.text as NSString).rangeOfCharacter(from: CharacterSet.newlines)
            let location = rangeOfNewLine.location
            //let length = (notes.text.characters.count - rangeOfNewLine.location)
            let range = NSMakeRange(0, location)
            let substring = (thenotes as NSString).substring(with: range)
            notesTitle = NSMutableAttributedString(string:substring, attributes:headerAttributes)
        }
        else
        {
            notesTitle = NSMutableAttributedString(string:thenotes, attributes:headerAttributes)
        }
        
        return notesTitle as NSAttributedString
    }


    // MARK: - TEXTFIELD / TEXTVIEW DELEGATE METHODS
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
       return true
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //scrollView.setContentOffset(CGPointMake(0, 50), animated: true)
        //println("pushed up")
        //eventsAlongTheWayPicker.hidden = true
    }
    
    

    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        txt = textField.text!
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
     textView.textColor = UIColor.white
        doneButton.isEnabled = true;
        if textView.text == PLACEHOLDER_TEXT
        {
            textView.text = "";
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView.text.isEmpty
        {
            textView.textColor = chosenThemePlaceholderTextColour
            textView.text = PLACEHOLDER_TEXT
            doneButton.isEnabled = false
        }
        else
        {
            doneButton.isEnabled = true;
            textView.textColor = UIColor.white
        }
    }
    
    
    
    func textViewDidChange(_ textView: UITextView)
    {

        let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
        newLineExists = predicate.evaluate(with: notes.text)
        
        if newLineExists == false
        {
            notes.attributedText = NSAttributedString(string:notes.text, attributes:headerAttributes)
            //print("applied the header attributes")
            if textView.text.length == 0
            {
                textView.text = PLACEHOLDER_TEXT
                textView.font = standardFont
                textView.textColor = chosenThemePlaceholderTextColour
                doneButton.isEnabled = false
            }else{
                textView.textColor = UIColor.white;
            }
        }
        else
        {
            let rangeOfNewLine = (notes.text as NSString).rangeOfCharacter(from: CharacterSet.newlines)
            
            // HEADER
            let location = rangeOfNewLine.location
            //let length = (notes.text.characters.count - rangeOfNewLine.location)
            let range = NSMakeRange(0, location)
            //println("range of header text: \(range).")
            let headerAttributedString = notes.attributedText.attributedSubstring(from: range)
            
            // BODY
            let bodyRange = NSMakeRange(location, notes.text.characters.count - location)
            
            //println("range of standard text: \(bodyRange).")
            
            let bodyString = (notes.text as NSString).substring(with: bodyRange)
            let bodyattributedString = NSAttributedString(string:bodyString, attributes:standardAttributes)
            
            //println("bodyattributedString: \(bodyattributedString). headerAttributedString: \(headerAttributedString)")
            
            let newAttributedString = NSMutableAttributedString()
            newAttributedString.append(headerAttributedString)
            newAttributedString.append(bodyattributedString)
            notes.attributedText = newAttributedString
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        // The text view calls this method whenever the user types a new character or deletes an existing character.
        
        //let predicate = NSPredicate(format: "SELF CONTAINS %@", argumentArray: ["\n"])
        //newLineExists = predicate.evaluateWithObject(notes.text)
        //println("Match = newLineExists? : \(newLineExists) and range of: \(range) and text of: \(text)")
        
        
        
        if textView.text == PLACEHOLDER_TEXT
        {
            textView.text = "";
            doneButton.isEnabled = false;
        }
        return true
    }


    @IBAction func clickStart(_ sender: Any) {

        //SHOW ACTION SHEET FOR CHOOSING START DATE
        let alertActionSheet = UIAlertController(title: nil, message: "Specify when will the event start on the  calendar, or use a trigger", preferredStyle: .actionSheet)

        // ADD CURRENT FATE (TODAY) OPTION
        alertActionSheet.addAction(UIAlertAction(title: NSLocalizedString("Today", comment: "Todays Date"), style: .default, handler: { _ in
            //ON SELECTED TODAY
            self.startDateButton.setTitle("Today", for: .normal)
        }))
        // ADD DATE CHOOSER OPTION
        alertActionSheet.addAction(UIAlertAction(title: NSLocalizedString("Pick a Date", comment: "Choose action"), style: .default, handler: { _ in

            //SELECTED DATE CHOOSER
           self.startDatePicker.becomeFirstResponder()
            // self.startDateButton.setTitle("Showing Date Picker", for: .normal)

        }))
        //ADD  X MANTHS AFTER Y FINISH OPTION
        alertActionSheet.addAction(UIAlertAction(title: NSLocalizedString("X months after Y ends", comment: "Default action"), style: .default, handler: { _ in
            // X MANTHS AFTER Y FINISH SELECTED
            GoalPickerViewController.show(from: self);
            self.startDateButton.setTitle(" Showing X Y Picker ", for: .normal)
        }))
        // ADD CANCEL OPTION
        alertActionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
            // JUST CLICKED CANCEL
        }))
        // PRESENT VIEW
        self.present(alertActionSheet, animated: true, completion: nil)
    }





}
