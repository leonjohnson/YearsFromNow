import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var pageIndex : Int!
    let backgroundImages = ["home", "home", "home", "nil"]
    
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if pageIndex > 2 || pageIndex.isNegative
        {
            // present a plain background as is
            skipButton.hidden = false
            logoView.hidden = true
            descriptionLabel.hidden = false
            descriptionLabel.text = "Let's get started"
            
        }
        else
        {
            if pageIndex == 0
            {
                logoView.hidden = false
            }
            else
            {
                logoView.hidden = true
            }
            
            
            let backgroundImage = UIImage(named: backgroundImages[pageIndex])
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
            
            backgroundImageView.clipsToBounds = true
            backgroundImageView.frame = self.view.frame
            
            self.view.addSubview(backgroundImageView)
            self.view.sendSubviewToBack(backgroundImageView)
            
            
            
        }
        
        let logoImage = UIImage(named: "logo")
        logoView = UIImageView(image: logoImage)
        
        descriptionLabel.textColor = UIColor.whiteColor()
        skipButton.backgroundColor = chosenThemeButtonColour
        
        
    }
    
    
    @IBAction func cancelOnboarding()
    {
        //let uivc = DisplayGoals() as UIViewController
        //self.navigationController?.pushViewController(uivc, animated: true)
        
        //performSegueWithIdentifier("showCreateEditView", sender: timeLineV.goal!)
    }
}



