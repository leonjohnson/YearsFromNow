//
//  ImagePickerViewController.swift
//  YearsFromNow
//
//  Created by toobler on 22/09/17.
//  Copyright © 2017 Leon Johnson. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var selectedIndex:Int = 0
    var parentPage: CreateEditGoals?;

    override func viewDidLoad() {
        super.viewDidLoad()

            // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelInsert()
    {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func done()
    {
        parentPage?.selectedCategoryIndex = selectedIndex;
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell")!
        if(indexPath.row == selectedIndex){
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        let label:UILabel = cell.viewWithTag(102) as! UILabel
        let imV:UIImageView =  cell.viewWithTag(101) as! UIImageView
        imV.backgroundColor = colorsCategoryList[indexPath.row];
        label.text = colorsCategoryName[indexPath.row] as? String
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row;
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (colorsCategoryList.count);
    }
    func numberOfSections(in tableView: UITableView) -> Int {
     return   1;
    }

    static func show(from:UIViewController ,selectedIndex: Int){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePickerViewController") as! ImagePickerViewController
        vc.selectedIndex = selectedIndex;
        vc.parentPage = from as! CreateEditGoals
        from.present(vc, animated: true) {
        };
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
