import RealmSwift
import Foundation

class Goal:Object
{
    dynamic var title = ""
    dynamic var notes = ""
    dynamic var start_date = Date()
    dynamic var start_after_goal = ""
    dynamic var start_days_after = ""
    dynamic var end_date = Date()
    let category = Categories()
    
    
    /// @brief This function converts 201509 to 'Sep 2015'
    func integerToDateString(_ integerDate:String) ->String
    {
        let index = integerDate.characters.index(integerDate.startIndex, offsetBy: 4)
        //integerDate[index] returns Character 'o'
        let endIndex = integerDate.characters.index(integerDate.endIndex, offsetBy: -2)
        let monthInt = Int(integerDate[(index ..< endIndex)])!-1
        let month = months[monthInt]
        let year = integerDate.substring(to: index)
        
        return month + " " + year
        
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
}

