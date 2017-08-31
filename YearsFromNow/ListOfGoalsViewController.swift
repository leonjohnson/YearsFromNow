import UIKit
import RealmSwift

class ListOfGoalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet var goalsTable : UITableView!
    @IBOutlet weak var dateSwitcher: UISegmentedControl!
    @IBOutlet weak var graphButton : UIButton!
    @IBOutlet weak var newGoalButton : UIButton!
    var goalsByMonth : [[Goal]] = []
    var goalsByQuarter : [[Goal]] = []
    var goalsByYear : [[Goal]] = []
    var currentYear : String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        
        // Segmented control
        let attributes = [NSFontAttributeName:lightFont, NSForegroundColorAttributeName:UIColor.black]
        let newAttributes = [NSFontAttributeName:systemFontBold13, NSForegroundColorAttributeName:UIColor.gray]
        dateSwitcher.setTitleTextAttributes(attributes, for: .normal)
        dateSwitcher.setTitleTextAttributes(newAttributes, for: .selected)
        
        // TableView
        goalsTable.backgroundColor = UIColor.clear
        goalsTable.separatorColor = UIColor.white
        
        //Button bar
        let calendarImage = #imageLiteral(resourceName: "calendar")
        graphButton.setImage(calendarImage, for: .normal)
        graphButton.tintColor = UIColor.white
        
        let addGoalImage = #imageLiteral(resourceName: "add")
        newGoalButton.setImage(addGoalImage, for: .normal)
        newGoalButton.tintColor = UIColor.white
        
        
        fetchGoals()
        goalsTable.reloadData()
        dateSwitcher.addTarget(self, action: #selector(reloadTableView(sender:)), for: .valueChanged)
        graphButton.addTarget(self, action: #selector(backToGraphView), for: UIControlEvents.touchUpInside)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func startOfQuarter(startDate: Date) -> Date {
        var components = Calendar.current.dateComponents([.month, .day, .year], from: startDate)
        let newMonth: Int
        switch components.month! {
        case 1,2,3: newMonth = 1
        case 4,5,6: newMonth = 4
        case 7,8,9: newMonth = 7
        case 10,11,12: newMonth = 10
        default: newMonth = 1
        }
        components.month = newMonth
        return Calendar.current.date(from: components)!
    }
    
    func goalsFoundBetweenDates(startDate: Date, endDate: Date, displayDate: Date) -> Bool {
        let fallsBetween = (startDate...endDate).contains(displayDate)
        return fallsBetween
    }
    
    func fetchGoals(){
        do {
            let realm = try Realm()
            let goals = realm.objects(Goal.self)
            
            for g in goals {
                print("goal note:", g.notes)
            }
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
            
            //let comp = (calendar as Calendar).dateComponents([.year, .month, .quarter], from: today)
            
            /*
            let numbers = [1, 1, 1, 3, 3, 4]
            let numberGroups = Set(numbers).map{ value in return numbers.filter{$0==value} }
            */
            
            for month in 0...119 {
                let displayDate = Calendar.current.date(byAdding: .month, value: month, to: startOfThisMonth!)
                var goalsInCurrentMonth : [Goal] = []
                for goal in goals {
                    let isGoalInDisplayMonth = goalsFoundBetweenDates(startDate: goal.start_date, endDate: goal.end_date, displayDate: displayDate!)
                    if isGoalInDisplayMonth == true {
                        goalsInCurrentMonth.append(goal)
                    }
                }
                if goalsInCurrentMonth.count > 0 {
                    goalsByMonth.append(goalsInCurrentMonth)
                    for each in goalsByMonth {
                        print("each", each)
                    }
                }
                

            }
            
            for quarter in 0...29 {
                let displayQuarter : Date = Calendar.current.date(byAdding: .month, value: (quarter * 3), to: Date())! // quarter * 3 for a qtr
                
                let quarter_start_date = startOfQuarter(startDate: displayQuarter)
                let quarter_end_date = Calendar.current.date(byAdding: .month, value: 3, to: quarter_start_date)!
                let quarterDateRange = quarter_start_date...quarter_end_date
                
                
                var goalsInCurrentQuarter : [Goal] = []
                for goal in goals {
                    let goalDateRange = goal.start_date...goal.end_date
                    if quarterDateRange.overlaps(goalDateRange) {
                        goalsInCurrentQuarter.append(goal)
                    }
                }
                
                if goalsInCurrentQuarter.count > 0{
                    goalsByQuarter.append(goalsInCurrentQuarter)
                }
                
            }
            let thisYear = extracted.year!
            
            for year in 0...11 {
                var goalsInCurrentYear : [Goal] = []
                for goal in goals {
                    let yearGoalStarts = (calendar as Calendar).dateComponents([.year], from: goal.start_date).year!
                    let yearGoalEnd = (calendar as Calendar).dateComponents([.year], from: goal.end_date).year!
                    if (yearGoalStarts == (thisYear + year) || yearGoalEnd == (thisYear + year))  {
                       goalsInCurrentYear.append(goal)
                        
                    }
                }
                if goalsInCurrentYear.count > 0{
                    goalsByYear.append(goalsInCurrentYear)
                }
                
                print("CURRENT YEAR : \(goalsByYear)")
            }
        } catch  {
            print(error)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch dateSwitcher.selectedSegmentIndex {
        case 0:
            print("calling numberOfSections for MONTH")
            return goalsByMonth.count // It shouldn't be 10 years worth of months, only the number of months that we have data for.
        case 1:
            print("calling numberOfSections for QUARTER")
            return goalsByQuarter.count // quarters
        case 2:
            print("calling numberOfSections for YEAR")
            return goalsByYear.count // years
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch dateSwitcher.selectedSegmentIndex {
        case 0:
            var comps = DateComponents()
            comps.month = section
            let nextMonth = ((calendar as NSCalendar).date(byAdding: comps, to: today, options: []))!
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            let month = formatter.string(from: nextMonth)
            return month
            
        case 1:
            var yearForLabel = Int(currentYear)
            print("current year is \(String(describing: yearForLabel))")
            var quarterCount = section
            let remainder = (section + 0)%4
            if remainder == 0 {
                //yearForLabel! += 1
                quarterCount = 1
            } else {
                quarterCount = remainder + 1
            }
            
            yearForLabel = yearForLabel! + (Int(section/4))

            let qString = "Q" + String(quarterCount) + " " + String(yearForLabel!).uppercased()
            /*
            let label = UILabel(frame: CGRect(x: section * 110, y: dateLabelYPosition, width: 100, height: 20))
            label.font = dateFont
            label.text = qString
            label.textColor = chosenThemeTextColour
            label.textAlignment = .center
             */
            return qString
            
        case 2:
            var comps = DateComponents()
            comps.year = section
            let thisYear = ((calendar as NSCalendar).date(byAdding: comps, to: today, options: []))!
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY"
            let year = formatter.string(from: thisYear)
            return year
            
        default:
            return ""
        }
        

    }
    
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //
    }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("calling numberOfRowsInSection")
        switch dateSwitcher.selectedSegmentIndex {
        case 0:
            print("Section %@ has %@ number of rows.", section, goalsByMonth[section].count)
            return goalsByMonth[section].count
            
        case 1:
            return goalsByQuarter[section].count
            
        case 2:
            return goalsByYear[section].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("calling numberOfRowsInSection")
        let section = indexPath.section
        let row = indexPath.row
        let labelText:String
        
        switch dateSwitcher.selectedSegmentIndex {
        case 0:
            labelText = goalsByMonth[section][row].notes
        case 1:
            labelText = goalsByQuarter[section][row].notes
        case 2:
            labelText = goalsByYear[section][row].notes
        default:
            labelText = "Deafult fallthrough"
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "yfn", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = labelText
        return cell
    }
    
    
    func reloadTableView(sender:UISegmentedControl){
        print("About to reload goals table")
        goalsTable.reloadData()
    }
    
    func backToGraphView(){
        self.navigationController?.popViewController(animated: true)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
