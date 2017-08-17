import UIKit

class OnBoard: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    let pageTitles = ["Title 1", "Title 2", "Title 3", "Title 4"]
    var images = ["long3.png","long4.png","long1.png","long2.png"]
    var numberOfIntroScreens = 5
    var currentIndexOfScreen = 0
    
    var pageViewController : UIPageViewController!
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "YearsFromNow_launchedBefore")
        if launchedBefore == true
        {
            cancelOnboarding()
        }
        else
        {
            //print("NO,never launched before.")
            UserDefaults.standard.set(true, forKey: "YearsFromNow_launchedBefore")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let launchedBefore = UserDefaults.standard.bool(forKey: "YearsFromNow_launchedBefore")
        if launchedBefore == false
        {
            reset()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func swiped(_ sender: AnyObject) {
        
        self.pageViewController.view .removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
        reset()
    }
    
    
    
    func reset() {
        /* Getting the page View controller */
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(0)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        self.pageViewController.view.backgroundColor = UIColor.black
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    }
    
    func cancelOnboarding()
    {
        let uivc = self.storyboard?.instantiateViewController(withIdentifier: "DisplayGoals")
        self.navigationController?.pushViewController(uivc!, animated: true)
        
        performSegue(withIdentifier: "skipOnboarding", sender: nil)
    }
    
    
    
    @IBAction func start(_ sender: AnyObject) {
        let pageContentViewController = self.viewControllerAtIndex(0)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! PageContentViewController).pageIndex!
        index += 1
        if index >= numberOfIntroScreens
        {
            return nil
        }
        else
        {
            return self.viewControllerAtIndex(index)
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! PageContentViewController).pageIndex!
        if index <= 0
        {
            return nil
        }
        else
        {
            index -= 1
            return self.viewControllerAtIndex(index)
        }
    }
    
    
    
    func viewControllerAtIndex(_ index : Int) -> UIViewController?
    {
        if(index >= numberOfIntroScreens)
        {
        return nil
        }
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
    
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return numberOfIntroScreens
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if completed
        {
            currentIndexOfScreen =  previousViewControllers.count
            print("This is index number \(currentIndexOfScreen)" )
        }
        else
        {
            "did not complete"
        }
    }
}
