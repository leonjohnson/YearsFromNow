//
//  Constants.swift
//  LifePath
//
//  Created by Leon Johnson on 18/03/2015.
//  Copyright (c) 2015 Leon Johnson. All rights reserved.
//

import UIKit

let months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
let calendar = NSCalendar.currentCalendar()
let today = NSDate()

let timeLineHeight = 40

// Theme
enum APP_BACKGROUND_COLOURS: String {
    case BLUE = "BLUE"
    case NEUTRAL_BLUE = "NEUTRAL_BLUE"
    case PURPLE_SUNSET = "PURPLE_SUNSET"
    case CORAL_GREEN = "CORAL_GREEN"
    case CORN_YELLOW = "CORN_YELLOW"
    case OFF_WHITE = "OFF_WHITE"
}
var APP_BACKGROUND = APP_BACKGROUND_COLOURS.CORAL_GREEN

// Colours
var chosenThemeTextColour:UIColor?
var chosenThemeAccentColour :UIColor?
var chosenThemeButtonColour :UIColor?
var chosenThemePlaceholderTextColour :UIColor?
var chosenThemeCursorColour =  UIView.appearance().tintColor  // The default cursor colour.

var purple = UIColor(red: CGFloat(100)/255, green: CGFloat(102)/255, blue: (200)/255, alpha: 1.0)
var white = UIColor.whiteColor()


// Fonts - use this to create a new font - UIFont(name: , size: )
let onBoardLabelFont = UIFont.systemFontOfSize(17, weight: UIFontWeightThin) //UIFont(name: "HelveticaNeue-Thin", size: 18)!
let titleFont = UIFont.systemFontOfSize(28, weight: UIFontWeightThin) //UIFont(name: "HelveticaNeue-Thin", size: 28)!
let standardFont = UIFont.systemFontOfSize(15, weight: UIFontWeightRegular)//UIFont(name: "HelveticaNeue-Thin", size: 14)!
let systemFontBold15 = UIFont.systemFontOfSize(15, weight: UIFontWeightBold)//UIFont(name: "Helvetica-Bold", size: 15.0)!
let systemFontBold13 = UIFont.systemFontOfSize(13, weight: UIFontWeightBold)//UIFont(name: "Helvetica-Bold", size: 12.0)!
let labelFont = UIFont.systemFontOfSize(16, weight: UIFontWeightBold)//UIFont(name: "HelveticaNeue-Bold", size: 16)!
let logoFont = UIFont.systemFontOfSize(12, weight: UIFontWeightBold)//UIFont(name: "Helvetica-Bold", size: 12.0)!
let lightFont = UIFont.systemFontOfSize(13, weight: UIFontWeightThin)//UIFont(name: "Helvetica-Light", size: 12.0)!
let dateFont = UIFont.systemFontOfSize(16, weight: UIFontWeightThin)//UIFont(name: "Helvetica-Light", size: 16.0)!
let yearFont = UIFont.systemFontOfSize(18, weight: UIFontWeightThin)//UIFont(name: "Helvetica-Light", size: 18.0)!
let timeLineLabelFont = UIFont.systemFontOfSize(12, weight: UIFontWeightBold)//UIFont(name: "Helvetica-Bold", size: 12.0)!


let headerAttributes = [NSFontAttributeName: systemFontBold15]
let standardAttributes = [NSFontAttributeName: standardFont]


func themeSelected()
{
    if APP_BACKGROUND == APP_BACKGROUND_COLOURS.CORAL_GREEN
    {
        chosenThemeTextColour = white
        chosenThemeAccentColour = UIColor.whiteColor()
        chosenThemeButtonColour = UIColor(red: 0.263, green: 0.686, blue: 0.584, alpha: 1.000)
        chosenThemePlaceholderTextColour = UIColor.grayColor().colorWithAlphaComponent(0.7)
        chosenThemeCursorColour =  UIView.appearance().tintColor  // The default cursor colour.
    }
}

// Timeline attributes
let dateLabelLength : CGFloat = 110
let gapBetweenGoalBars = 100

enum DIRECTION: String {
    case UP = "UP"
    case DOWN = "DOWN"
}


// Label heights
let timeLineLabelWidth : CGFloat = 200
let timeLineLabelHeight : CGFloat = 40
let dateLabelYPosition = 10
let PLACEHOLDER_TEXT = "Describe a goal that you have..."
var showEndDateTooltip = true
var showCreateNewGoalTooltip = true




