//
//  SettingsViewController.swift
//  YearsFromNow
//
//  Created by toobler m.zalih on 13/09/17.
//  Copyright © 2017 Leon Johnson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // GUESTURE REGOGNIZER
    lazy var dismissGestureRecognizer: UIPanGestureRecognizer = {
        // PAN WITH DELEGATE SELF AND SELECTOR PANDISMISS
        let pan = UIPanGestureRecognizer(target: self, action: #selector(SettingsViewController.panDismiss(_:)))
        // ADD TO SUPER VIEW
        self.view.addGestureRecognizer(pan)
        // WILL HANDLE LATER IF ANY SUBVIEW HAS GUESTURE
        return pan
    }()
    // DISMISS ANIMATION CONTROL DELEGATE
    weak var modalDelegate: ModalViewControllerDelegate?
    // ON CANCEL BUTTON CLICK
    @IBAction func dissmissClick(_ sender: UIButton) {
        modalDelegate?.modalViewControllerDismiss(callbackData: nil)
    }

    override var prefersStatusBarHidden: Bool{
        return false;
    }
    // PAN GUESTURE REGOGNISED
    func panDismiss(_ sender: UIPanGestureRecognizer) {

        switch sender.state {
        case .began :
            // CHECK IS UPWORD SWIPE
            guard sender.translation(in: view).y < 0 else {
                break
            }
            // PAN DISMISSS WITH INTERACTION
            modalDelegate?.modalViewControllerDismiss(true, callbackData: nil)
        default : break
        }
    }
}
