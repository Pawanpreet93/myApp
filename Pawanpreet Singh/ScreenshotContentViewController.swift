
import UIKit

class ScreenshotContentViewController: UIViewController {

    @IBOutlet weak var screenshotImageView: UIImageView!
    
    var pageIndex:Int!
    var imageFile:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.screenshotImageView.image = UIImage(named: self.imageFile)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
