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

    //GoalPickerViewController
     override func viewDidLoad() {
        super.viewDidLoad()
        taskPicker.completionBlock={ (goal) -> Void in
            self.selectedGoal = goal;
        }
        monthCountPicker.createInputView();

        monthCountPicker.completionBlock={ (goal) -> Void in

        }
        taskPicker.createInputView();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    static func show(from:UIViewController ){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoalPickerViewController") as! GoalPickerViewController
        from.present(vc, animated: true) {
        };
    }

    @IBAction func cancelInsert()
    {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func clickDone()
    {
        self.dismiss(animated: true, completion: nil)
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
