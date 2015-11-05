import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var swipeToBeginIntroLabel: UILabel!
    
    var pageIndex : Int!
    let backgroundImages = ["home", "timeline", "create", "bargraphs", "nil"]
    
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        skipButton.hidden = true
        swipeToBeginIntroLabel.hidden = false
        swipeToBeginIntroLabel.textColor = white
        swipeToBeginIntroLabel.font = systemFontBold15
        getStartedButton.hidden = true
        getStartedButton.backgroundColor = chosenThemeButtonColour
        getStartedButton.setTitleColor(chosenThemeTextColour, forState: UIControlState.Normal)
        getStartedButton.setTitle("Skip this intro", forState: UIControlState.Normal)
        var backgroundImage : UIImage
        
        if pageIndex >= (backgroundImages.count) || pageIndex.isNegative
        {
            // present a plain background as is
            skipButton.hidden = false
            getStartedButton.hidden = true
            logoView.hidden = true
        }
        else
        {
            switch pageIndex
            {
            case 0:
                logoView.hidden = false
                descriptionLabel.hidden = false
            case 1:
                logoView.hidden = true
                descriptionLabel.hidden = true
                swipeToBeginIntroLabel.hidden = true
            case 2:
                logoView.hidden = true
                descriptionLabel.hidden = true
                swipeToBeginIntroLabel.hidden = true
            case 3:
                logoView.hidden = true
                descriptionLabel.hidden = true
                swipeToBeginIntroLabel.hidden = true
            case 4:
                logoView.hidden = true
                descriptionLabel.hidden = true
                swipeToBeginIntroLabel.hidden = true
                getStartedButton.hidden = false
                getStartedButton.setTitle("Let's get started!", forState: UIControlState.Normal)
                getStartedButton.center.y = (getStartedButton.center.y)+50
                
            default:
                break
            }
            
            /*
            if pageIndex == 0
            {
                logoView.hidden = false
            }
            else
            {
                logoView.hidden = true
            }
            */
            
            if pageIndex+1 < backgroundImages.count
            {
                backgroundImage = UIImage(named: backgroundImages[pageIndex])!
                let backgroundImageView = UIImageView(image: backgroundImage)
                backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
                
                backgroundImageView.clipsToBounds = true
                backgroundImageView.frame = self.view.frame
                
                self.view.addSubview(backgroundImageView)
                self.view.sendSubviewToBack(backgroundImageView)
            }
            
            
            
            
            
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



