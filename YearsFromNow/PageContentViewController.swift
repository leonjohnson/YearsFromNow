import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var pageIndex: Int?
    var titleText : String!
    var imageName : String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heroImage = UIImage(named: "home")
        let backgroundImageView = UIImageView(image: heroImage)
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        backgroundImageView.clipsToBounds = true
        
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)

        
        //self.view.bringSubviewToFront(logoLabel)
        //self.view.bringSubviewToFront(descriptionLabel)
        
        logoLabel.textColor = UIColor.whiteColor()
        descriptionLabel.textColor = UIColor.whiteColor()
        
        

        
    }
}