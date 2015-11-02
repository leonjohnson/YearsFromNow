//
//  ViewController.swift
//  YearsFromNow
//
//  Created by Leon Johnson on 14/09/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayGoals: UIViewController, UIScrollViewDelegate
{

    // MARK - VARIABLES
    @IBOutlet weak var bkgrd: UIView!
    @IBOutlet weak var dateSwitcher: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var createNewGoalButtonItem: UIBarButtonItem!
    @IBOutlet weak var toolTip : Tooltip!
    
    let calendar = NSCalendar.currentCalendar()
    let today = NSDate()
    var scrollDataTable : [[String:CGFloat]] = []
    var middleOfScreen : (x:CGFloat, y:CGFloat) = (0,0)
    var currentQuarter : Int = Int()
    var currentYear : String = String()
    var timeLinesArray : [TimeLineView] = []
    var timeLineLabelsArray : [UILabel] = []
    var dateLabelArray : [UILabel] = []
    var lastYContentOffset : CGFloat = 0
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set the traits
        createNewGoalButtonItem.tintColor = chosenThemeAccentColour
        self.navigationItem.leftBarButtonItem?.tintColor = chosenThemeAccentColour
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
        navigationController?.navigationBar.hidden = false
        
        

        let attributes = [NSFontAttributeName:lightFont]
        let newAttributes = [NSFontAttributeName:systemFontBold13, NSForegroundColorAttributeName:UIColor.grayColor()]
        dateSwitcher.setTitleTextAttributes(attributes, forState: .Normal)
        dateSwitcher.setTitleTextAttributes(newAttributes, forState: .Selected)
        let comp = calendar.components([.Year, NSCalendarUnit.Month] , fromDate: today)
        currentYear = String(comp.year).uppercaseString
        self.navigationItem.leftBarButtonItem?.title = currentYear
        
        
        
        switch comp.month
        {
        case 1,2,3:
            currentQuarter = 1
        case 4,5,6:
            currentQuarter = 2
        case 7,8,9:
            currentQuarter = 3
        case 10,11,12:
            currentQuarter = 4
        default:
            currentQuarter = -1
        }
        
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        navigationController?.navigationBarHidden = false
        
        middleOfScreen = (self.view.frame.width/2, self.view.frame.height/2)
        
        removeAllLabelsFromDateScrollView()
        displayDates()
        displayGoals("")
        
        
        let launchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("YearsFromNow_launchedBefore")
        if launchedBefore == true
        {
            //print("YES,launched before.")
            showEndDateTooltip = false
            showCreateNewGoalTooltip = false
        }
        else
        {
            //print("NO,never launched before.")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "YearsFromNow_launchedBefore")
            
           
            //let mystoryBoard = UIStoryboard(name: "Main", bundle: nil)
            //let onBoardVC = mystoryBoard.instantiateViewControllerWithIdentifier("OnBoard") as! OnBoard
            //self.navigationController?.presentViewController(onBoardVC, animated: false, completion: nil)
        }
        
        /*
        var showit = true
        for subview in self.scrollView.subviews
        {
            if subview.isMemberOfClass(TimeLineView) == true
            {
                showit = false
            }
        }
        
        if showit == true
        {
            let tt2 = toolTip
            tt2.backgroundColor = UIColor.clearColor()
            tt2.frame = CGRectMake(self.view.frame.width/3, self.view.frame.height/3, 100.0, 100.0)
            scrollView.addSubview(tt2)
        }
        */
        
        
        
        let numberOfLaunchesKeyExists = NSUserDefaults.standardUserDefaults().boolForKey("YearsFromNow_numberOfLaunches")
        if numberOfLaunchesKeyExists == true
        {
            
            var launchCount = NSUserDefaults.standardUserDefaults().integerForKey("YearsFromNow_numberOfLaunches")
            //print("numberOfLaunchesKeyExists == \(numberOfLaunchesKeyExists) WITH \(launchCount) launces")
            if launchCount == 1
            {
                //print("This is the first time the user is seeing the screen.")
                self.scrollView.setContentOffset((CGPoint(x: 1000, y: 0)), animated: false)
                UIView.animateWithDuration(2.0, delay: 0, options: .CurveEaseOut, animations:
                    {
                        self.scrollView.setContentOffset((CGPoint(x: 0, y: 0)), animated: true)
                        
                    }, completion:
                    {
                        finished in
                        //self.centreAllTimelinelabels()
                        
                    }
                )
            }
            launchCount+=1
            NSUserDefaults.standardUserDefaults().setInteger(launchCount, forKey: "YearsFromNow_numberOfLaunches")
        }
        else
        {
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "YearsFromNow_numberOfLaunches")
        }
        
        
        

        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        self.view.setNeedsDisplay()
        middleOfScreen = (self.scrollView.frame.width/2, self.scrollView.frame.height/2)
    }
    
    
    
    func displayDates()
    {
        //var months : [String] = Array()
        //var quarters : [String] = Array()
        //let components = calendar.components([NSCalendarUnit.Month, .Quarter], fromDate: today)
        
        // get 10 years from now
        let comps = NSDateComponents()
        comps.month = 1
        
        var nextMonth : NSDate
        switch dateSwitcher.selectedSegmentIndex
        {
        case 0:
            scrollView.contentSize = CGSizeMake((dateLabelLength * 120), 20)
            for index in 0...119
            {
                comps.month = index
                
                //Get next months date
                nextMonth = (calendar.dateByAddingComponents(comps, toDate: today, options: []))!
                
                let label = UILabel(frame: CGRect(x: index*110, y: dateLabelYPosition, width: 100, height: 20))
                
                let formatter = NSDateFormatter()
                formatter.dateFormat = "MMM"
                let month = formatter.stringFromDate(nextMonth)
                
                label.font = dateFont
                label.text = month.uppercaseString
                label.textColor = chosenThemeTextColour
                label.textAlignment = .Center
                
                //Now add the line
                let lineRect = CGRectMake(CGFloat(index*110), CGFloat(dateLabelYPosition), 0.5, scrollView.frame.size.height)
                let line = UIView(frame: lineRect)
                line.backgroundColor = chosenThemeAccentColour
                line.alpha = 0.4
                scrollView.addSubview(line)
                
                scrollView.addSubview(label)
                dateLabelArray.append(label) // so we can iterate on this labels for repositioning easily.
                
                
            }
            
        case 1:
            scrollView.contentSize = CGSizeMake((dateLabelLength * 40), 20)
            var yearForLabel = Int(currentYear)
            var quarterCount = 0
            for index in 0...40
            {
                quarterCount++
                let qString = "Q" + String(quarterCount) + " " + String(yearForLabel!).uppercaseString
                let label = UILabel(frame: CGRect(x: index * 110, y: dateLabelYPosition, width: 100, height: 20))
                label.font = dateFont
                label.text = qString
                label.textColor = chosenThemeTextColour
                label.textAlignment = .Center
                scrollView.addSubview(label)
                if (index+1)%4 == 0
                {
                    yearForLabel!++
                    quarterCount = 0
                }
                
                //Now add the line
                let lineRect = CGRectMake(CGFloat(index*110), CGFloat(dateLabelYPosition), 0.5, scrollView.frame.size.height)
                let line = UIView(frame: lineRect)
                line.backgroundColor = chosenThemeAccentColour
                line.alpha = 0.4
                scrollView.addSubview(line)
            }
            
        case 2:
            scrollView.contentSize = CGSizeMake((dateLabelLength * 10), 20)
            let yearForLabel = Int(currentYear)
            for index in 0...10
            {
                let label = UILabel(frame: CGRect(x: index*110, y: dateLabelYPosition, width: 100, height: 20))
                label.font = dateFont
                label.text = String(yearForLabel! + index)
                label.textColor = chosenThemeTextColour
                label.textAlignment = .Center
                scrollView.addSubview(label)
                
                //Now add the line
                let lineRect = CGRectMake(CGFloat(index*110), CGFloat(dateLabelYPosition), 0.5, scrollView.frame.size.height)
                let line = UIView(frame: lineRect)
                line.backgroundColor = chosenThemeAccentColour
                line.alpha = 0.4
                scrollView.addSubview(line)
            }
            
        default: break
            
        }
        scrollView.setContentOffset((CGPoint(x: 0, y: 0)), animated: true)
    }
    

    
    /// @brief This function converts 20150901 to and NSDate()
    func integerToNSDate(integerDate:String) -> NSDate
    {
        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        let comp = calendar.components(.Month, fromDate: today)
        let themonth = String(comp.month)
        let comp2 = calendar.components(.Year, fromDate: today)
        let theyear = String(comp2.year)
        let dateString = theyear + "-" + themonth + "-" + "01"
        return NSDate(dateString: dateString)
        
    }
    
    
    
    
    func displayGoals(predicate:String)
    {
        //print("Fetching Goals. 🐯")
        
        // get all the goals
        do
        {
            let realm = try Realm()
            
            let goals = realm.objects(Goal)
            //var goals = realm.objects(Goal).filter(predicate).sorted("date_added")
            
            let formatter = NSDateFormatter()
            let gbDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale:NSLocale(localeIdentifier: "en-GB"))
            formatter.dateFormat = gbDateFormat
            
            //Set up components for date calculations in for loop
            let components = NSDateComponents()
            let extracted = calendar.components([NSCalendarUnit.Month, .Year], fromDate: today)
            components.year = extracted.year
            components.month = extracted.month
            components.day = 01
            let startOfThisMonth = calendar.dateFromComponents(components)
            
            var heightOfContent = -50
            
            
            var loopProducingTimeLineView = 0
            var hiddenGoalsCount = 0
            for goalRetrieved: Goal in goals
            {
                // CALCULATE THE NUMBER OF MONTHS BETWEEN TODAY(1st) AND THE GOALS END_DATE (31st)
                let timeDifference = calendar.components([NSCalendarUnit.Month, .Year], fromDate: startOfThisMonth!, toDate: goalRetrieved.end_date, options: [])
                
                let monthsRemaining : CGFloat = CGFloat((timeDifference.year*12) + timeDifference.month + 1) // add one so we include this month as 1 whole month. See playground4 code for more.
                
                var w : CGFloat = 0.0
                switch dateSwitcher.selectedSegmentIndex
                {
                case 0: // month
                    w = monthsRemaining * dateLabelLength
                case 1: // quarter
                    w = (monthsRemaining/4) * dateLabelLength
                case 2: // year
                    w = (monthsRemaining/12) * dateLabelLength
                default:
                    w = 0.0
                }
                
                if w < dateLabelLength
                {
                    // This goal needs goal needs to be hidden as it has an end date of less than a 'quarter/month/year' in length
                    hiddenGoalsCount++
                }
                
                
            }
            
            
            
            if hiddenGoalsCount > 0
            {
                let label = UILabel(frame: CGRect(x: 0, y: 50, width: 300, height: 300))
                label.font = timeLineLabelFont
                label.textColor = UIColor.blackColor()
                label.numberOfLines = 3
                
                
                if hiddenGoalsCount > 1
                {
                    label.text = NSLocalizedString("\(hiddenGoalsCount) goals have been hidden as they have an end date of less than a \(dateSwitcher.titleForSegmentAtIndex(dateSwitcher.selectedSegmentIndex)!) in length.", comment: "")
                }
                if hiddenGoalsCount == 1
                {
                    label.text = NSLocalizedString("\(hiddenGoalsCount) goal has been hidden as it has an end date of less than a \(dateSwitcher.titleForSegmentAtIndex(dateSwitcher.selectedSegmentIndex)!) in length.", comment: "")
                }
                
                //Needed to position the label correctly. Interesting 😼.
                label.sizeToFit()
                
                scrollView.addSubview(label)
                timeLineLabelsArray.append(label)
                
                let subViews = scrollView.subviews
                for subview in subViews
                {
                    if subview.isMemberOfClass(TimeLineView) || subview.isMemberOfClass(TimeLineViewGoalLabel)
                    {
                        //subview.frame.origin.y-=50
                    }
                    
                }
            }

            
            
            
            for goalRetrieved: Goal in goals
            {
                // CALCULATE THE NUMBER OF MONTHS BETWEEN TODAY(1st) AND THE GOALS END_DATE (31st)
                let timeDifference = calendar.components([NSCalendarUnit.Month, .Year], fromDate: startOfThisMonth!, toDate: goalRetrieved.end_date, options: [])
                
                let monthsRemaining : CGFloat = CGFloat((timeDifference.year*12) + timeDifference.month + 1) // add one so we include this month as 1 whole month. See playground4 code for more.
                
                var w : CGFloat = 0.0
                switch dateSwitcher.selectedSegmentIndex
                {
                case 0: // month
                    w = monthsRemaining * dateLabelLength
                case 1: // quarter
                    w = (monthsRemaining/4) * dateLabelLength
                case 2: // year
                    w = (monthsRemaining/12) * dateLabelLength
                default:
                    w = 0.0
                }
                
                if w < dateLabelLength
                {
                    // This goal needs goal needs to be hidden as it has an end date of less than a 'quarter/month/year' in length
                    print("Too small to show")
                    
                    
                }
                else
                {
                    // We want to produce a TLView so let's increment
                    
                    
                    
                    // Create the TLView
                    var yCoordiante : CGFloat = CGFloat((gapBetweenGoalBars * loopProducingTimeLineView)+75)
                    
                    if hiddenGoalsCount > 0
                    {
                        yCoordiante+=100
                    }
                    let timeLineView = TimeLineView(frame: CGRect(x:0, y: Int(yCoordiante), width: Int(w), height:timeLineHeight))
                    timeLineView.backgroundColor = UIColor.blackColor()
                    timeLineView.alpha = 0.5
                    timeLineView.tag = loopProducingTimeLineView
                    
                    scrollView.addSubview(timeLineView)
                    timeLinesArray.append(timeLineView)
                    
                    scrollDataTable.append(["x":0, "length":w, "pointsRemaining":0, "y":yCoordiante])
                    
                    //let rect = CGRectMake(middleOfScreen.x - CGFloat(50), yCoordiante - (float(timeLineHeight) * float(0.3)), CGFloat(timeLineLabelWidth), CGFloat(timeLineLabelHeight))
                    
                    let label = TimeLineViewGoalLabel(frame: CGRect(x: Int(middleOfScreen.x) - Int(timeLineLabelWidth)/2, y: Int(yCoordiante) - timeLineHeight/2, width: Int(timeLineLabelWidth), height: Int(timeLineLabelHeight)))
                    
                    label.font = timeLineLabelFont
                    label.textColor = chosenThemeTextColour
                    let d = nsDateToDateString(goalRetrieved.end_date)
                    label.text = "\(loopProducingTimeLineView+1). " + goalRetrieved.notes + " (\(d))"
                    
                    label.sizeToFit()
                    label.frame.origin.x = middleOfScreen.x - label.frame.size.width/2
                    
                    //If the width of the TimeLine is smaller than the screen, let's reposition it nicely
                    if w < scrollView.frame.width
                    {
                        // Reposition is half way in the TimeLineView
//                        var newXPositionOfLabel : CGFloat = (w/2) - (label.frame.width/4)
                        
                        
                        // But if this new position would leave the label over hanging the width of the TimeLineview, then let's reposition it at 5 to give a little margin from 0.
                        if label.frame.width > timeLineView.frame.width
                        {

                        }
                        label.frame.origin.x = 5
                        
                    }
                    
                    
                    
                    
                    
                    scrollView.addSubview(label)
                    timeLineLabelsArray.append(label)
                    
                    
                    let timeLineTap = UITapGestureRecognizer(target: self, action: "editGoal:")
                    timeLineView.userInteractionEnabled = true
                    timeLineView.addGestureRecognizer(timeLineTap)
                    timeLineView.goalIndex = loopProducingTimeLineView
                    timeLineView.goal = goalRetrieved
                    heightOfContent+=(gapBetweenGoalBars + timeLineHeight)
                    
                    loopProducingTimeLineView++
                }
                
                
            }
            
            scrollView.contentSize.height = CGFloat(heightOfContent)
        }
            
        catch
        {
            print(error)
        }
        
        
    }
    
    
        
    
    func removeAllLabelsFromDateScrollView()
    {
        let subViews = scrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
     
        }
    }
    
    func removeAllTimeLinesFromDateScrollView()
    {
        let subViews = scrollView.subviews
        for subview in subViews
        {
            if subview.isMemberOfClass(TimeLineView)
            {
                subview.removeFromSuperview()
            }
            
        }
    }
    
     @IBAction func changeTimeUnitOfTimeLine(segmentedControl:UISegmentedControl)
    {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0: // month
            removeAllLabelsFromDateScrollView()
            displayDates()
            displayGoals("")
        case 1: // calender quarter
            removeAllLabelsFromDateScrollView()
            displayDates()
            displayGoals("")
        case 2: // year
            removeAllLabelsFromDateScrollView()
            displayDates()
            displayGoals("")
        default:
            break;
        }
        
    }

    
    
    //MARK - SCROLLING METHODS
    @IBAction func scrollToCurrentMonth()
    {
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations:
            {
                
            }, completion:
            {
                finished in                
                
            }
        )
    }
    
    func centreAllTimelinelabels()
    {
        let subViews = scrollView.subviews
        for subview in subViews
        {
            if subview.isMemberOfClass(TimeLineViewGoalLabel)
            {
                subview.frame.origin.x = middleOfScreen.x - subview.frame.width/2
            }
            
        }
    }
    
    
    
    
    // MARK - SCROLLVIEW DELEGATE METHODS
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        
        
        for (index, timeline) in timeLinesArray.enumerate()
        {
            middleOfScreen = (self.scrollView.frame.width/2 + scrollView.contentOffset.x, self.scrollView.frame.height/2 + scrollView.contentOffset.y)
            
            var amountofTimeLineViewStillToCome = (scrollView.frame.width) - (timeline.frame.width - scrollView.contentOffset.x)
            amountofTimeLineViewStillToCome = amountofTimeLineViewStillToCome * (-1)
            if amountofTimeLineViewStillToCome >= 0
            {
                // keep the label centred
                let labelToRePosition = timeLineLabelsArray[index]
                labelToRePosition.frame.origin.x = middleOfScreen.x - labelToRePosition.frame.width/2
            }
        }
        
        /*
        lastYContentOffset = scrollView.contentOffset.y
        
        if scrollView.contentOffset.y > lastYContentOffset
        {
            fadeTimeLine(scrollView.contentOffset, direction: DIRECTION.UP)
            println("UP...")
        }
        else
        {
            println("DOWN...")
            fadeTimeLine(scrollView.contentOffset, direction: DIRECTION.DOWN)
        }
        */
        
        
        switch dateSwitcher.selectedSegmentIndex
        {
        case 0: // month
            let monthsPassed = floor(scrollView.contentOffset.x/dateLabelLength)
            let comps = NSDateComponents()
            comps.month = Int(monthsPassed)
            let dateToMostLeft = (calendar.dateByAddingComponents(comps, toDate: today, options: []))!
            //updateLabelsPositionsWhenScrolling(scrollView.contentOffset, timelinexPosition: 0)
            let comp2 = calendar.components(.Year, fromDate: dateToMostLeft)
            let year = comp2.year
            self.navigationItem.leftBarButtonItem?.title = String(year)
            
        case 1: // calender quarter
            let quarterJustPassed = floor(scrollView.contentOffset.x/dateLabelLength)
            let yearToDisplay = Int(currentYear)! + Int(quarterJustPassed/4)
            self.navigationItem.leftBarButtonItem?.title = String(yearToDisplay)
            
        case 2: // year
            let yearPassed = floor(scrollView.contentOffset.x/dateLabelLength)
            self.navigationItem.leftBarButtonItem?.title = String(Int(currentYear)! + Int(yearPassed))
            
        default:
            break;
        }
        
        
    }
    
    
    func fadeTimeLine(offset: CGPoint, direction: DIRECTION)
    {
        for TL in timeLinesArray
        {
            if (offset.y >= TL.frame.origin.y) && (offset.y <= (TL.frame.origin.y+50)) // within the range of a TimeLineView
            {
                if direction == DIRECTION.UP
                {
                    TL.fadeOut()
                    
                }
                else
                {
                    TL.fadeIn()
                }
            }
        }
    }
    
    func updateLabelsPositionsWhenScrolling(offset: CGPoint, timelinexPosition: CGFloat)
    {
        
        

        
        // update positing of date labels
        if offset.y != 0
        {
            for label in dateLabelArray
            {
                label.frame.origin.y = offset.y
            }
        }
        else
        {
            for label in dateLabelArray
            {
                label.frame.origin.y = 0
            }
        }
        
        
    }
    
    
    func editGoal(sender:UITapGestureRecognizer)
    {
        let timeLineV = sender.view as! TimeLineView
        performSegueWithIdentifier("showCreateEditView", sender: timeLineV.goal!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if ((segue.identifier == "showCreateEditView" && (sender?.isMemberOfClass(UIBarButtonItem)) == false)) // This was invoked by tapping a TLView not the plus sign
        {
            let goal : Goal = sender as! Goal
            //var vc = CreateEditGoals()
            let vc = segue.destinationViewController as! CreateEditGoals
            vc.editableGoal = goal
            vc.userIsNew = false
            return
            
        }
        
        if (segue.identifier == "showCreateEditView" && sender?.isMemberOfClass(UIBarButtonItem) == true && timeLinesArray.count > 0)
        {
            //This user is not new to this app as they have created TLViews before
            let vc = segue.destinationViewController as! CreateEditGoals
            vc.userIsNew = false
        }
        
    }
    
    func nsDateToDateString(date:NSDate) ->String
    {
        // NSDate to 'Sep 2015'
        print("received : \(date)")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        var formattedDateString = dateFormatter.stringFromDate(date)
        print("step 0: \(formattedDateString)")

        formattedDateString.removeAtIndex(formattedDateString.startIndex.advancedBy(3))
        print("step 1: \(formattedDateString)")
        
        formattedDateString.removeAtIndex(formattedDateString.startIndex.advancedBy(3))
        print("step 2: \(formattedDateString)")
        
        formattedDateString.removeAtIndex(formattedDateString.startIndex.advancedBy(3))
        print("step 3 \(formattedDateString.uppercaseString)")
        return formattedDateString.uppercaseString
    }

    
    
    
    
    
    
    
    
    
    
    
    
        

}

