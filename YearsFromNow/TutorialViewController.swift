//
//  TutorialViewController.swift
//  YearsFromNow
//
//  Created by toobler m.zalih on 14/09/17.
//  Copyright © 2017 Leon Johnson. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dissmissClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil);
    }
    static func showPage(viewController:UIViewController){

        // Check is initial Page Show
        if(!UserDefaults.standard.bool(forKey: "transpView"))
    {
        // Presenting  a rtransperant view over the current view as a tutorial
        UserDefaults.standard.set(true, forKey: "transpView")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "transpView")

        //For iOS 8 & above only
        vc.providesPresentationContextTransitionStyle = true;
        vc.definesPresentationContext = true;
        vc.modalPresentationStyle = .overCurrentContext;

        viewController.present(vc, animated: false) {
        };
    }
    }
}
