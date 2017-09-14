import UIKit
import RealmSwift
import UnderKeyboard

class ViewController: UIViewController {
    
    @IBOutlet weak var name : UITextView!
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    let underKeyboardLayoutConstraint = UnderKeyboardLayoutConstraint()
    let keyboardObserver = UnderKeyboardObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Done button View for NumberPad KeyBoard
        let barButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: name, action: #selector(UIResponder.resignFirstResponder))
        barButton.tintColor = UIColor.black
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        toolbar.items = [barButton]
        name.inputAccessoryView = toolbar
        
        
        //UnderKeyBoard Library functionality
        underKeyboardLayoutConstraint.setup(bottomLayoutConstraint, view: view,
                                            bottomLayoutGuide: bottomLayoutGuide)
        keyboardObserver.start()
        // Called before the keyboard is animated
        keyboardObserver.willAnimateKeyboard = { height in
            self.bottomLayoutConstraint.constant = height
        }
        // Called inside the UIView.animateWithDuration animations block
        keyboardObserver.animateKeyboard = { height in
            self.scrollView.layoutIfNeeded()
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
