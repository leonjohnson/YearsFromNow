import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var swipeToBeginIntroLabel: UILabel!
    
    var pageIndex : Int!
    let backgroundImages = ["home", "timeline", "create", "bargraphs", "nil"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        skipButton.isHidden = true
        swipeToBeginIntroLabel.isHidden = false
        swipeToBeginIntroLabel.textColor = white
        swipeToBeginIntroLabel.font = systemFontBold15
        getStartedButton.isHidden = true
        getStartedButton.backgroundColor = chosenThemeButtonColour
        getStartedButton.setTitleColor(chosenThemeTextColour, for: UIControlState())
        getStartedButton.setTitle("Skip this intro", for: UIControlState())
        var backgroundImage : UIImage
        
        if pageIndex >= (backgroundImages.count) || pageIndex.isNegative
        {
            // present a plain background as is
            skipButton.isHidden = false
            getStartedButton.isHidden = true
            logoView.isHidden = true
        }
        else
        {
            switch pageIndex
            {
            case 0:
                logoView.isHidden = false
                descriptionLabel.isHidden = false
            case 1:
                logoView.isHidden = true
                descriptionLabel.isHidden = true
                swipeToBeginIntroLabel.isHidden = true
            case 2:
                logoView.isHidden = true
                descriptionLabel.isHidden = true
                swipeToBeginIntroLabel.isHidden = true
            case 3:
                logoView.isHidden = true
                descriptionLabel.isHidden = true
                swipeToBeginIntroLabel.isHidden = true
            case 4:
                logoView.isHidden = true
                descriptionLabel.isHidden = true
                swipeToBeginIntroLabel.isHidden = true
                getStartedButton.isHidden = false
                getStartedButton.setTitle("Let's get started!", for: UIControlState())
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
                backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
                
                backgroundImageView.clipsToBounds = true
                backgroundImageView.frame = self.view.frame
                
                self.view.addSubview(backgroundImageView)
                self.view.sendSubview(toBack: backgroundImageView)
            }
            
            
            
            
            
        }
        
        let logoImage = UIImage(named: "logo")
        logoView = UIImageView(image: logoImage)
        
        descriptionLabel.textColor = UIColor.white
        skipButton.backgroundColor = chosenThemeButtonColour
        
        
    }
    
    
    
}



