
import UIKit

class DrawViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
     @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var eraser: UIButton!{
        didSet{
            eraser.layer.cornerRadius = eraser.frame.width/2
        }
    }
    @IBOutlet weak var resetButton: UIButton!{
        didSet{
            resetButton.layer.cornerRadius = resetButton.frame.width / 2
        }
    }
    
    @IBOutlet weak var eraserImageView: UIImageView!
    
    private var lastPoint = CGPoint.zero
    private var red: CGFloat = 0.0
    private var green: CGFloat = 0.0
    private var blue: CGFloat = 0.0
    private var brushWidth: CGFloat = 10.0
    private var opacity: CGFloat = 1.0
    private var swiped = false
    private var selectedColor : CGColor!
    private var isEraserEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deviceOrientationChecks()

        randomColor()
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("draw Something!",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel

    }
    
    @IBAction func eraserButton(sender: UIButton) {
        if isEraserEnabled{
            randomColor()
            eraserImageView.image = UIImage(named: "eraser")
        }else{
            selectedColor = UIColor.whiteColor().CGColor
            eraserImageView.image = UIImage(named: "paint")
        }
        isEraserEnabled = !isEraserEnabled
    }

    @IBAction func shareButtonAction(sender: UIBarButtonItem) {
        UIGraphicsBeginImageContext(mainImageView.bounds.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0,
            width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(activity, animated: true, completion: nil)
    }
    
    
    @IBAction func resetButtonAction(sender: UIButton) {
         mainImageView.image = nil
        randomColor()
        eraserImageView.image = UIImage(named: "eraser")
        isEraserEnabled = false
    }
    
    
    // MARK: - Drawing Functions

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch! {
            lastPoint = touch.locationInView(self.view)
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetStrokeColorWithColor(context, selectedColor)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        CGContextStrokePath(context)
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = true
        if let touch = touches.first as UITouch! {
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !swiped {
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
        if !isEraserEnabled{
        randomColor()
        }
    }
 
    func randomColor(){
    
            let number:UInt32 = arc4random() % 12
            
            switch number {
            case 1:
                selectedColor = Colors.blueish.CGColor
            case 2:
                selectedColor = Colors.greenish.CGColor
            case 3:
                selectedColor = Colors.reddish.CGColor
            case 4:
                selectedColor = Colors.yellowish.CGColor
            case 5:
                selectedColor = Colors.blueColor.CGColor
            case 6:
                selectedColor = Colors.cyanish.CGColor
            case 7:
                selectedColor = Colors.pinkish.CGColor
            case 8:
                selectedColor = Colors.cellBackgroundCyan.CGColor
            case 9:
                selectedColor = Colors.cellBackgroundPink.CGColor
            case 10:
                selectedColor = Colors.cellBackgroundOrange.CGColor
            case 11:
                selectedColor = Colors.cellBackgroundGreen.CGColor
            default:
                selectedColor = Colors.cellBackgroundPurple.CGColor
            
        }
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        deviceOrientationChecks()
    }
    
    func deviceOrientationChecks(){
        switch UIDevice.currentDevice().orientation{
            
        case .LandscapeLeft, .LandscapeRight:
            tempImageView.hidden = true
            mainImageView.hidden = true
            messageLabel.text = "Please change the Orientation"
            resetButton.hidden = true
            eraser.hidden = true
            eraserImageView.hidden = true
            mainImageView.image = nil
            tempImageView.image = nil

        case .Portrait,.PortraitUpsideDown:
            mainImageView.image = nil
            tempImageView.image = nil
            tempImageView.hidden = false
            mainImageView.hidden = false
            messageLabel.text = "Once you start drawing Pick your finger to switch between colors."
            resetButton.hidden = false
            eraser.hidden = false
            eraserImageView.hidden = false
        default:
            break
        }
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    
}
