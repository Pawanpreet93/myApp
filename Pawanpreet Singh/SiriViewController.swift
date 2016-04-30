
import UIKit

class SiriViewController: UIViewController, LTMorphingLabelDelegate {

    //MARK: Data Arrays
    private let textArray = ["\"What is \"","\"What is your Name?\""]
    private let answerArray = ["My name is","My name is Pawanpreet Singh."]
    private let moreArray = ["\"Anything Else?\""]
    private let tapArray = ["Tap Mic!"]

    // MARK: Variables
    private var timer = NSTimer()
    private var count = 0
    
    // MARK: Outlets
    @IBOutlet private var questionLabel: LTMorphingLabel!
    @IBOutlet private var answerLabel: LTMorphingLabel!
    @IBOutlet private var moreLabel: LTMorphingLabel!
    @IBOutlet private var tapLabel: LTMorphingLabel!
    @IBOutlet private var micButton: UIButton!
    @IBOutlet private var micImage: UIImageView!

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = textArray[0]

        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(SiriViewController.assignLabels), userInfo: nil, repeats: true)
        
    }
    
    func assignLabels(){

        switch count{
        case 0:
            questionLabel.text = textArray[1]
        case 1:
            answerLabel.text = answerArray[0]
        case 2:
            answerLabel.text = answerArray[1]
        case 3:
            moreLabel.text = moreArray[0]
        case 4:
             tapLabel.text = tapArray[0]
        default:
            self.micButton.enabled = true
            UIView.animateWithDuration(1.0, animations: {
                self.micImage.alpha = 1.0
            })

            timer.invalidate()

          
            
        }
        count += 1
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}