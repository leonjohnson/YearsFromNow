//
//  GoalPickerViewController.swift
//  YearsFromNow
//
//  Created by toobler on 22/09/17.
//  Copyright © 2017 Leon Johnson. All rights reserved.
//

import UIKit

class GoalPickerViewController: UIViewController {

      @IBOutlet weak var taskPicker: TaskPicker!
      @IBOutlet weak var monthCountPicker: NumberPicker!



    var selectedGoal : Goal?  = nil;
    var selectedMonths : Int?  = 0;
    var parentPage: CreateEditGoals?;


    //GoalPickerViewController
     override func viewDidLoad() {
        super.viewDidLoad()

        selectedGoal = parentPage?.conectedGoal
        selectedMonths = parentPage?.conectedGoalMonthsAfter

        if(selectedGoal != nil){
            taskPicker.text = (selectedGoal?.notes)!;
        }
        taskPicker.completionBlock={ (goal) -> Void in
            self.selectedGoal = goal;
        }
        monthCountPicker.createInputView();
        monthCountPicker.setSelected(selection: selectedMonths!);

        monthCountPicker.completionBlock={ (goal) -> Void in
            self.selectedMonths = goal
        }
        taskPicker.currentTask = parentPage?.editableGoal;
        taskPicker.createInputView();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    static func show(from:UIViewController ){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoalPickerViewController") as! GoalPickerViewController
        vc.parentPage = from as? CreateEditGoals ;
          from.present(vc, animated: true) {
        };
    }

    @IBAction func cancelInsert()
    {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func clickDone()
    {
        if  self.parentPage != nil {
            setDateAndText(parent: parentPage!);
        }
        self.dismiss(animated: true, completion: nil)
    }
    func setDateAndText(parent :CreateEditGoals){

        //END DATE
        let dateEnd :Date  = selectedGoal!.end_date as Date

        let startDate = Calendar.current.date(byAdding: .month, value: self.selectedMonths!, to: dateEnd)

        let dateString = CreateEditGoals.nsDateToDateString(startDate!)

        let month_abb_end = dateString.components(separatedBy: " ")[0]

        //Set the var correctly
        parent.startDatePicker.currentlyDisplayedMonthIndex = months.index(of: month_abb_end)!
        let displayedYearEnd = Int((dateString.components(separatedBy: " ")[1]))
        parent.startDatePicker.currentlyDisplayedYearIndex = displayedYearEnd! - parent.startDatePicker.startYear
        parent.startDatePicker.selectedDate()


        parent.conectedGoal = selectedGoal ;
        parent.conectedGoalMonthsAfter = selectedMonths ;
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
