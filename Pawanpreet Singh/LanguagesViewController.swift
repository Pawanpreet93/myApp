
import UIKit

class LanguagesViewController: UIViewController {

    @IBOutlet var languageLabels: [UILabel]!
    @IBOutlet weak var graphView: LanguagesGraph!
    
    private let languageLabelColors = [Colors.greenish, Colors.blueish, Colors.yellowish, Colors.pinkish,Colors.cyanish, Colors.reddish,Colors.blueColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("languages Summary",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        for index in 0..<languageLabels.count{
            languageLabels[index].textColor = languageLabelColors[index]
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LanguagesViewController.TapGestureAction(_:)))
        tapGesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapGesture)
        self.graphView.addGestureRecognizer(tapGesture)

        graphView.transform = CGAffineTransformMakeScale(0.1, 0.1)

    UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: {
        self.graphView.alpha = 1.0
        self.graphView.transform = CGAffineTransformMakeScale(1,1)

        }) { (true) in
            self.animateLabels()
        }
    
    }
    
    func TapGestureAction(gesture:UITapGestureRecognizer){
        performSegueWithIdentifier("ShowLanguageDetailSegue", sender: nil)
    }

    func animateLabels(){
        for labelIndex in 0..<languageLabels.count{
        UIView.animateWithDuration(0.5, delay: 0.5 * Double(labelIndex), options: .CurveEaseIn, animations: {
            self.languageLabels[labelIndex].alpha = 1.0
            }, completion: nil)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
