
import UIKit

class WWDCViewController: UIViewController {

    @IBOutlet var titleLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("why WWDC?",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        for i in 0..<titleLabels.count{
            
            UIView.animateWithDuration(0.7, delay: Double(i) * 0.7, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.titleLabels[i].alpha = 1.0
                }, completion: nil)
            
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
