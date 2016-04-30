
import UIKit

class InterestsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet  var circles: [UIView]!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var interestIcon: UIImageView!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Variables
    private var currentIndex = 0
    private let interestsTitle = ["Photography", "Solo Travelling","EDM","Hindi Songs", "Poetry", "Reading Novels", "Cooking"]
    private let interestImages = ["photographyIcon","travellingIcon", "edmIcon","hindiMusicIcon", "writingIcon", "readingIcon","cookingIcon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("my Interests",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
     
        mainView.layer.cornerRadius = mainView.frame.width/2
        
        interestIcon.image = UIImage(named: interestImages[currentIndex])
        interestLabel.text = interestsTitle[currentIndex]
        
        for circle in circles{
            circle.layer.cornerRadius = circle.frame.width/2
            circle.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }
        
        randomColor()

        for i in 0..<circles.count{
            
            UIView.animateWithDuration(0.2, delay: Double(i) * 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: { 
                self.circles[i].transform = CGAffineTransformMakeScale(1,1)
                }, completion: { (true) in
                    self.interestLabel.alpha = 1
                    self.interestIcon.alpha = 1
            })
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(InterestsViewController.SwipeGestureAction(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(InterestsViewController.SwipeGestureAction(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
      
    }

    func SwipeGestureAction(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right:
                    decrement()
            case UISwipeGestureRecognizerDirection.Left:
                    increment()
               

            default:
                break
            }
        }
    }

    func increment(){
        if currentIndex < interestsTitle.count - 1 {
            currentIndex += 1
            interestIcon.image = UIImage(named: interestImages[currentIndex])
            interestLabel.text = interestsTitle[currentIndex]
            randomColor()
            pageControl.currentPage = currentIndex
        }
    }
    
    func decrement(){
        if currentIndex > 0 {
            currentIndex -= 1
            interestIcon.image = UIImage(named: interestImages[currentIndex])
            interestLabel.text = interestsTitle[currentIndex]
            randomColor()
            pageControl.currentPage = currentIndex
        }

    }
    
    
    func randomColor(){
        for circle in circles{
            
            let number:UInt32 = arc4random() % 5
            
            switch number {
            case 1:
                circle.backgroundColor = Colors.blueish
            case 2:
                circle.backgroundColor = Colors.greenish
            case 3:
                circle.backgroundColor = Colors.reddish
            case 4:
                circle.backgroundColor = Colors.yellowish
            default:
                circle.backgroundColor = Colors.cellBackgroundPurple
            }
        }

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
        
}