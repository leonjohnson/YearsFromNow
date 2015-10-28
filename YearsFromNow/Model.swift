import RealmSwift
import Foundation

class Goal:Object
{
    dynamic var title = ""
    dynamic var notes = ""
    dynamic var start_date = NSDate()
    dynamic var end_date = NSDate()
    
    
    
    
    
    
    

    
    
    
    
    /// @brief This function converts 201509 to 'Sep 2015'
    func integerToDateString(integerDate:String) ->String
    {
        let index = integerDate.startIndex.advancedBy(4)
        integerDate[index] // returns Character 'o'
        let endIndex = integerDate.endIndex.advancedBy(-2)
        let monthInt = Int(integerDate[Range(start: index, end: endIndex)])!-1
        let month = months[monthInt]
        let year = integerDate.substringToIndex(index)
        
        return month + " " + year
        
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
}

