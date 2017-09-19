//
//  ViewController.swift
//  YearsFromNow
//
//  Created by Leon Johnson on 14/09/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit
import RealmSwift


class DisplayGoals: UIViewController, UIScrollViewDelegate,ModalTransitionDelegate,UIGestureRecognizerDelegate
{
    /// Retain transition delegate.
    var tr_presentTransition: TRViewControllerTransitionDelegate?


    // MARK - VARIABLES
    @IBOutlet weak var bkgrd: UIView!
    @IBOutlet weak var dateSwitcher: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var createNewGoalButtonItem: UIBarButtonItem!
    @IBOutlet weak var toolTip : Tooltip!
    @IBOutlet weak var calendarButton : UIButton!
    @IBOutlet weak var newGoalButton : UIButton!
    
    let calendar = Calendar.current
    let today = Date()
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
        
        // Navbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.isHidden = false
        
        
        //Date switcher
        
        let yearLabelAttributes = [NSFontAttributeName:yearFont, NSForegroundColorAttributeName:UIColor.white]
        let attributes = [NSFontAttributeName:mediumFont, NSForegroundColorAttributeName:UIColor.white]
        let newAttributes = [NSFontAttributeName:systemFontBold13, NSForegroundColorAttributeName:UIColor.gray]
        
        dateSwitcher.setTitleTextAttributes(attributes, for: .normal)
        dateSwitcher.setTitleTextAttributes(newAttributes, for: .selected)
        let comp = (calendar as Calendar).dateComponents([.year, .month], from: today)
        currentYear = String(describing: comp.year!).uppercased()
        
        self.navigationItem.leftBarButtonItem?.title = currentYear
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(yearLabelAttributes, for: .normal)
        
        //Button bar
        let calendarImage = #imageLiteral(resourceName: "calendar")
        calendarButton.setImage(calendarImage, for: .normal)
        calendarButton.tintColor = UIColor.white
        
        let addGoalImage = #imageLiteral(resourceName: "add")
        newGoalButton.setImage(addGoalImage, for: .normal)
        newGoalButton.tintColor = UIColor.white
        
        switch comp.month!
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
        
        //Set the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        backgroundImage.contentMode = UIViewContentMode.topLeft
        self.view.insertSubview(backgroundImage, at: 0)

        // ADD PAN GUESTURE TO SCROLL VIEW TO SHOW SETTINGS PAGE
         addPan(scrollView);
    }
    override func viewDidAppear(_ animated: Bool)
    {
        // SHOWING A TUTORIAL PAGE FOR SETTINGS 
        // ABOUVE THE CURRENT VIEW
        // ITS SHOWS ONLY FOR ONE TIME
        TutorialViewController.showPage(viewController: self);
    }
        // DELEGATE METHOD GUSTURE
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // HANDLING MULTIPLE GUESTURE
        return true;

    }
    func addPan(_ view : UIView){
        // CREATING A PAN GUESTURE TO THE SCROLL VIEW
        // TARGET SELF AND SELECTER INTERACTIVE TRANSACTION
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DisplayGoals.interactiveTransition(_:)))

        // SELF AS DELEGATE INVOKES DELEGATE METHOD FOR GUSTURE
        pan.delegate = self
        // ADDDING PAN GUSTURE TO VIEW
        view.addGestureRecognizer(pan)
    }

    // THIS VERIABLE CHECK WHETHER ITS A VERTICAL SWIPE OR NOT
    var verticalSwipe = false;

    // INTERACTIVE OPENING OF SETTING PAGE 
    // WE CAN CAUSTUMIZE THE RESPONSE TIME RELATION DIRECTION ETC
    func interactiveTransition(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:

            // SET MINIMUM DOWNWORD VELOCITY
            guard sender.velocity(in: view).y > 0 else { break }

            // SET MINIMUM DOWNWORD TRANSLATION
              guard sender.translation(in: view).y >= 0 else {
                break
              }
            // ENSURE TRANSLATION PREFER DOWNWOR THAN SIDES
            guard sender.translation(in: view).y >=  sender.translation(in: view).x else {
                break
            }
            verticalSwipe = true;
            // SETTINGS PAGE VIEW CONTROLLER
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsView") as! SettingsViewController
                vc.modalDelegate = self
            // PRESENTING PAGE WITH ANIMATION LIBRARY
            tr_presentViewController(vc, method: Transition.scanbot(present: sender, dismisTransiltion: vc.dismissGestureRecognizer), completion: nil)
            
        default: break
        }
    }
    override var prefersStatusBarHidden: Bool{
        // NOT FOR NOW
        return false;
    }

    override func viewWillAppear(_ animated: Bool)
    {
        // CHECK IS SWIPE FOR SETTINGS
        if(verticalSwipe){
            // REVERT BACK
            verticalSwipe = false;
            // DONOT DO REOAD JUST RETURN
            return;
        }
        navigationController?.isNavigationBarHidden = false
        
        middleOfScreen = (self.view.frame.width/2, self.view.frame.height/2)
        
        removeAllLabelsFromDateScrollView()
        displayDates()
        displayGoals("")
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "YearsFromNow_launchedBefore")
        if launchedBefore == true
        {
            //print("YES,launched before.")
            showEndDateTooltip = false
            showCreateNewGoalTooltip = false
        }
        else
        {
            //print("NO,never launched before.")
            UserDefaults.standard.set(true, forKey: "YearsFromNow_launchedBefore")
            
           
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
        
        
        
        let numberOfLaunchesKeyExists = UserDefaults.standard.bool(forKey: "YearsFromNow_numberOfLaunches")
        if numberOfLaunchesKeyExists == true
        {
            
            var launchCount = UserDefaults.standard.integer(forKey: "YearsFromNow_numberOfLaunches")
            //print("numberOfLaunchesKeyExists == \(numberOfLaunchesKeyExists) WITH \(launchCount) launces")
            if launchCount == 1
            {
                //print("This is the first time the user is seeing the screen.")
                self.scrollView.setContentOffset((CGPoint(x: 1000, y: 0)), animated: false)
                UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations:
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
            UserDefaults.standard.set(launchCount, forKey: "YearsFromNow_numberOfLaunches")
        }
        else
        {
            UserDefaults.standard.set(1, forKey: "YearsFromNow_numberOfLaunches")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
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
        var comps = DateComponents()
        comps.month = 1
        print("called, with : %@", dateSwitcher.selectedSegmentIndex)
        var nextMonth : Date
        switch dateSwitcher.selectedSegmentIndex
        {
        case 0:
            scrollView.contentSize = CGSize(width: (dateLabelLength * 120), height: 20)
            for index in 0...119
            {
                comps.month = index
                
                //Get next months date
                nextMonth = ((calendar as NSCalendar).date(byAdding: comps, to: today, options: []))!
                
                let label = UILabel(frame: CGRect(x: index*110, y: dateLabelYPosition, width: 100, height: 20))
                
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM"
                let month = formatter.string(from: nextMonth)
                
                label.font = dateFont
                label.text = month.uppercased()
                label.textColor = chosenThemeTextColour
                label.textAlignment = .center
                
                //Now add the line
                let lineRect = CGRect(x: CGFloat(index*110), y: CGFloat(dateLabelYPosition), width: 0.5, height: scrollView.frame.size.height)
                let line = UIView(frame: lineRect)
                line.backgroundColor = chosenThemeAccentColour
                line.alpha = 0.4
                scrollView.addSubview(line)
                
                scrollView.addSubview(label)
                dateLabelArray.append(label) // so we can iterate on this labels for repositioning easily.
            }
            
        case 1:
            scrollView.contentSize = CGSize(width: (dateLabelLength * 40), height: 20)
            var yearForLabel = Int(currentYear)
            var quarterCount = 0
            for index in 0...40
            {
                quarterCount += 1
                let qString = "Q" + String(quarterCount) + " " + String(yearForLabel!).uppercased()
                let label = UILabel(frame: CGRect(x: index * 110, y: dateLabelYPosition, width: 100, height: 20))
                label.font = dateFont
                label.text = qString
                label.textColor = chosenThemeTextColour
                label.textAlignment = .center
                scrollView.addSubview(label)
                if (index+1)%4 == 0
                {
                    yearForLabel! += 1
                    quarterCount = 0
                }
                
                //Now add the line
                let lineRect = CGRect(x: CGFloat(index*110), y: CGFloat(dateLabelYPosition), width: 0.5, height: scrollView.frame.size.height)
                let line = UIView(frame: lineRect)
                line.backgroundColor = chosenThemeAccentColour
                line.alpha = 0.4
                scrollView.addSubview(line)
            }
            
        case 2:
            scrollView.contentSize = CGSize(width: (dateLabelLength * 10), height: 20)
            let yearForLabel = Int(currentYear)
            for index in 0...10
            {
                let label = UILabel(frame: CGRect(x: index*110, y: dateLabelYPosition, width: 100, height: 20))
                label.font = dateFont
                label.text = String(yearForLabel! + index)
                label.textColor = chosenThemeTextColour
                label.textAlignment = .center
                scrollView.addSubview(label)
                
                //Now add the line
                let lineRect = CGRect(x: CGFloat(index*110), y: CGFloat(dateLabelYPosition), width: 0.5, height: scrollView.frame.size.height)
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
    func integerToNSDate(_ integerDate:String) -> Date
    {
        let calendar = Calendar.current
        let today = Date()
        let comp = (calendar as NSCalendar).components(.month, from: today)
        let themonth = String(describing: comp.month)
        let comp2 = (calendar as NSCalendar).components(.year, from: today)
        let theyear = String(describing: comp2.year)
        let dateString = theyear + "-" + themonth + "-" + "01"
        return Date(dateString: dateString)
        
    }
    
    
    
    
    func displayGoals(_ predicate:String)
    {
        //print("Fetching Goals. 🐯")
        
        // get all the goals
        do
        {
            let realm = try Realm()
            
            let goals = realm.objects(Goal.self)
            //var goals = realm.objects(Goal).filter(predicate).sorted("date_added")
            
            let formatter = DateFormatter()
            let gbDateFormat = DateFormatter.dateFormat(fromTemplate: "MMddyyyy", options: 0, locale:Locale(identifier: "en-GB"))
            formatter.dateFormat = gbDateFormat
            
            //Set up components for date calculations in for loop
            var components = DateComponents()
            let extracted = (calendar as Calendar).dateComponents([.month, .year], from: today)
            components.year = extracted.year
            components.month = extracted.month
            components.day = 01
            let startOfThisMonth = calendar.date(from: components)
            
            var heightOfContent = -50
            
            
            var loopProducingTimeLineView = 0
            var hiddenGoalsCount = 0
            for goalRetrieved: Goal in goals
            {
                // CALCULATE THE NUMBER OF MONTHS BETWEEN TODAY(1st) AND THE GOALS END_DATE (31st)
                let timeDifference = calendar.dateComponents([.month, .year], from: startOfThisMonth!, to: goalRetrieved.end_date)
                //OLD CODElet timeDifference = calendar.dateComponents([.Month, .Year], fromDate: startOfThisMonth!, toDate: goalRetrieved.end_date)
                
                let monthsRemaining : CGFloat = CGFloat((timeDifference.year!*12) + timeDifference.month! + 1) // add one so we include this month as 1 whole month. See playground4 code for more.
                
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
                    hiddenGoalsCount+=1
                }
                
                
            }
            
            
            
            if hiddenGoalsCount > 0
            {
                let label = UILabel(frame: CGRect(x: 0, y: 50, width: 300, height: 300))
                label.font = timeLineLabelFont
                label.textColor = UIColor.black
                label.numberOfLines = 3
                
                
                if hiddenGoalsCount > 1
                {
                    label.text = NSLocalizedString("\(hiddenGoalsCount) goals have been hidden as they have an end date of less than a \(dateSwitcher.titleForSegment(at: dateSwitcher.selectedSegmentIndex)!) in length.", comment: "")
                }
                if hiddenGoalsCount == 1
                {
                    label.text = NSLocalizedString("\(hiddenGoalsCount) goal has been hidden as it has an end date of less than a \(dateSwitcher.titleForSegment(at: dateSwitcher.selectedSegmentIndex)!) in length.", comment: "")
                }
                
                //Needed to position the label correctly. Interesting 😼.
                label.sizeToFit()
                
                scrollView.addSubview(label)
                timeLineLabelsArray.append(label)
                
                let subViews = scrollView.subviews
                for subview in subViews
                {
                    if subview.isMember(of: TimeLineView.self) || subview.isMember(of: TimeLineViewGoalLabel.self)
                    {
                        //subview.frame.origin.y-=50
                    }
                    
                }
            }

            
            
            
            for goalRetrieved: Goal in goals
            {
                // CALCULATE THE NUMBER OF MONTHS BETWEEN TODAY(1st) AND THE GOALS END_DATE (31st)
                // OLD CODE let timeDifference = calendar.components([NSCalendar.Unit.Month, .Year], fromDate: startOfThisMonth!, toDate: goalRetrieved.end_date, options: [])
                let timeDifference = calendar.dateComponents([.month, .year], from: startOfThisMonth!, to: goalRetrieved.end_date)
                
                let monthsRemaining : CGFloat = CGFloat((timeDifference.year!*12) + timeDifference.month! + 1) // add one so we include this month as 1 whole month. See playground4 code for more.
                
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
                    //print("Too small to show")
                    
                    
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
                    timeLineView.backgroundColor = UIColor.black
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
                    
                    
                    let timeLineTap = UITapGestureRecognizer(target: self, action: #selector(DisplayGoals.editGoal(_:)))
                    timeLineView.isUserInteractionEnabled = true
                    timeLineView.addGestureRecognizer(timeLineTap)
                    timeLineView.goalIndex = loopProducingTimeLineView
                    timeLineView.goal = goalRetrieved
                    heightOfContent+=(gapBetweenGoalBars + timeLineHeight)
                    
                    loopProducingTimeLineView+=1
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
            if subview.isMember(of: TimeLineView.self)
            {
                subview.removeFromSuperview()
            }
            
        }
    }
    
     @IBAction func changeTimeUnitOfTimeLine(_ segmentedControl:UISegmentedControl)
    {
        print("selected: \(segmentedControl.selectedSegmentIndex)")
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
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations:
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
            if subview.isMember(of: TimeLineViewGoalLabel.self)
            {
                subview.frame.origin.x = middleOfScreen.x - subview.frame.width/2
            }
            
        }
    }
    
    
    
    
    // MARK - SCROLLVIEW DELEGATE METHODS
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        
        for (index, timeline) in timeLinesArray.enumerated()
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
            var comps = DateComponents()
            comps.month = Int(monthsPassed)
            //OLD CODE let dateToMostLeft = ((calendar as Calendar).date(byAdding: comps, to: today, options: []))!
            let dateToMostLeft = (calendar as Calendar).date(byAdding: comps, to: today)!
            //updateLabelsPositionsWhenScrolling(scrollView.contentOffset, timelinexPosition: 0)
            //OLD CODE let comp2 = (calendar as Calendar).date(.year, from: dateToMostLeft)
            let comp2 = (calendar as Calendar).dateComponents([.year], from: dateToMostLeft)
            let year = comp2.year!
            self.navigationItem.leftBarButtonItem?.title = String(describing: year)
            
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
    
    
    func fadeTimeLine(_ offset: CGPoint, direction: DIRECTION)
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
    
    func updateLabelsPositionsWhenScrolling(_ offset: CGPoint, timelinexPosition: CGFloat)
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
    
    
    func editGoal(_ sender:UITapGestureRecognizer)
    {
        //let timeLineV = sender.view as! TimeLineView
        //performSegueWithIdentifier("showCreateEditView", sender: timeLineV.goal!)
        
        DispatchQueue.main.async(execute: { () -> Void in
            let timeLineV = sender.view as! TimeLineView
            self.performSegue(withIdentifier: "showCreateEditView", sender: timeLineV.goal!)
        })

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if ((segue.identifier == "showCreateEditView" && ((sender as AnyObject).isMember(of: UIBarButtonItem.self)) == false)) // This was invoked by tapping a TLView not the plus sign
        {
            let goal : Goal = sender as! Goal
            //var vc = CreateEditGoals()
            let vc = segue.destination as! CreateEditGoals
            vc.editableGoal = goal
            vc.userIsNew = false
            return
            
        }
        else
        {
            if (segue.identifier == "showCreateEditView" && (sender as AnyObject).isMember(of: UIBarButtonItem.self) == true && timeLinesArray.count > 0)
            {
                //This user is not new to this app as they have created TLViews before
                let vc = segue.destination as! CreateEditGoals
                vc.userIsNew = false
            }
            
            
            if segue.identifier == "list" {
                let vc = segue.destination as! ListOfGoalsViewController
                vc.currentYear = currentYear
            }
        }
        
        
    }
    
    func nsDateToDateString(_ date:Date) ->String
    {
        // NSDate to 'Sep 2015'
        print("received : \(date)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        var formattedDateString = dateFormatter.string(from: date)
        #if DEBUG
            print("step 0: \(formattedDateString)")
        #endif
        

        formattedDateString.remove(at: formattedDateString.characters.index(formattedDateString.startIndex, offsetBy: 3))
        #if DEBUG
            print("step 1: \(formattedDateString)")
        #endif
        
        
        formattedDateString.remove(at: formattedDateString.characters.index(formattedDateString.startIndex, offsetBy: 3))
        #if DEBUG
            print("step 2: \(formattedDateString)")
        #endif
        
        
        formattedDateString.remove(at: formattedDateString.characters.index(formattedDateString.startIndex, offsetBy: 3))
        #if DEBUG
            print("step 3 \(formattedDateString.uppercaseString)")
        #endif
        
        
        return formattedDateString.uppercased()
    }


}



