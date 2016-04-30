
import UIKit

class ScreenshotViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    
    var  pageViewControllers: UIPageViewController!
    
    var images :NSArray!

    var selectedApp  = NSIndexPath()
    var selectedCell = NSIndexPath()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("app Screenshots",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
                
        let appName = MyAppsData.appNames[selectedApp.row]
        
        images = NSArray(objects: "\(appName)0","\(appName)1","\(appName)2","\(appName)3","\(appName)4") as! [String]
        
        self.pageViewControllers = self.storyboard?.instantiateViewControllerWithIdentifier("ScreenshotsPageViewController") as! UIPageViewController
        
        self.pageViewControllers.dataSource = self
        self.pageViewControllers.delegate = self
        
        let startVC = self.viewControllerAtIndex(selectedCell.row) as ScreenshotContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewControllers.setViewControllers(viewControllers as! [ScreenshotContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewControllers.view.frame = CGRectMake(0, 80, self.view.frame.width, self.view.frame.height)

        self.addChildViewController(self.pageViewControllers)
        self.view.addSubview(self.pageViewControllers.view)
        self.pageViewControllers.didMoveToParentViewController(self)
  
        pageControl.currentPage = selectedCell.row
        pageControl.numberOfPages = images.count
        self.view.bringSubviewToFront(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewControllerAtIndex(index:Int) -> ScreenshotContentViewController{
        
        if self.images.count == 0 || index >= self.images.count{
            return ScreenshotContentViewController()
        }

        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ContentPageViewController") as! ScreenshotContentViewController
        
        vc.imageFile = self.images[index] as! String 
        vc.pageIndex = index
        
        return vc
    }
    
    //   MARK: - Page View Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ScreenshotContentViewController
        var index = vc.pageIndex as Int
        
        pageControl.currentPage = vc.pageIndex as Int
        
        if index == NSNotFound{
            return nil
        }
        index += 1
        
        if index == self.images.count{
            return nil
        }
        
       
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ScreenshotContentViewController
        var index = vc.pageIndex as Int

        pageControl.currentPage = vc.pageIndex as Int
        
        if index == 0 || index == NSNotFound{
            return nil
        }
        index -= 1
        
        
        return self.viewControllerAtIndex(index)
        
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.images.count
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
