import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var pageIndex : Int!
    let backgroundImages = ["home", "home", "home", "nil"]
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if pageIndex > 2 || pageIndex.isNegative
        {
            // present a plain background as is
            
        }
        else
        {
            let backgroundImage = UIImage(named: backgroundImages[pageIndex])
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
            
            backgroundImageView.clipsToBounds = true
            backgroundImageView.frame = self.view.frame
            
            self.view.addSubview(backgroundImageView)
            self.view.sendSubviewToBack(backgroundImageView)
            
            
            
        }
        
        logoLabel.textColor = UIColor.whiteColor()
        descriptionLabel.textColor = UIColor.whiteColor()
    }
}