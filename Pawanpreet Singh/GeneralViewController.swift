
import UIKit
import MessageUI

class GeneralViewController: UIViewController,UITextFieldDelegate,MFMailComposeViewControllerDelegate  {

    // MARK: Outlets
    @IBOutlet var myImageBackView: UIView!
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var countryFlagImage: UIImageView!
    
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var steveLabel: UILabel!
    @IBOutlet var bottomMessageLabel: UILabel!
    
    @IBOutlet var contactButtons: [UIButton]!
    @IBOutlet var contactButtonsImages: [UIImageView]!
    
    // MARK: Variables
    var urlString:String!
    var titleString:String!
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("pawanpreet Singh",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        deviceOrientationChecks()
        
        myImage.layer.cornerRadius = 60
        myImage.layer.borderColor = UIColor.whiteColor().CGColor
        myImage.layer.borderWidth = 3
        
        countryFlagImage.layer.borderWidth = 2
        countryFlagImage.layer.borderColor = Colors.blueColor.CGColor
        
        countryFlagImage.layer.cornerRadius = 15
        
        myImage.clipsToBounds = true
        countryFlagImage.clipsToBounds = true

        for eachButton in contactButtons{
            eachButton.layer.cornerRadius = 30
            eachButton.clipsToBounds = true
        }
        
        // Long press gesture on My pic
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(GeneralViewController.animateContactButtons(_:)))
        longPressGesture.minimumPressDuration = 1.0

        myImageBackView.addGestureRecognizer(longPressGesture)
        
    }

    // MARK: Handle Device Orientation Function
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
     deviceOrientationChecks()
    }
    
    func deviceOrientationChecks(){
        switch UIDevice.currentDevice().orientation{
            
        case .LandscapeLeft, .LandscapeRight:
            self.quoteLabel.hidden = true
            self.steveLabel.hidden = true
        case .Portrait,.PortraitUpsideDown:
            self.quoteLabel.hidden = false
            self.steveLabel.hidden = false
        default:
            break
        }
    }
    
    // MARK: Handling Contact Buttons
    func animateContactButtons(gesture:UILongPressGestureRecognizer){
        for i in 0..<contactButtons.count{
            UIView.animateWithDuration(0.5, delay: Double(i) * 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.contactButtons[i].alpha = 1.0
                self.contactButtonsImages[i].alpha = 1.0
                }, completion: { (true) in
                    self.myImageBackView.removeGestureRecognizer(gesture)
            })
        }
    }
    
    @IBAction func contactButtonAction(sender: UIButton) {

        switch sender.tag {
        case 1:
            callNumber("+919803423596")
        case 2:
            urlString = "https://in.linkedin.com/in/pawanpreetsingh"
            titleString = "linkedIn Profile"
            openURL()
        case 3:
            urlString = "https://twitter.com/PawanpreetPawan"
            titleString = "twitter Profile"
            openURL()
        case 4:
            sendMail()
        default:
            break
        }
    }

    private func callNumber(phoneNumber:String) {
        
        let alert = UIAlertController(title: "Do you want to make cellular call?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.Default, handler: { action in
        
            if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
                let application:UIApplication = UIApplication.sharedApplication()
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL);
                }else{
                    let alert = UIAlertController(title: "Alert", message: "Sorry you cant make a phone call. Try Again later", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    private func sendMail(){
        let mainViewController = MFMailComposeViewController()
        mainViewController.mailComposeDelegate=self
        mainViewController.setSubject("WWDC '16 App Mailer")
        mainViewController.setToRecipients(["pawanpreetsingh@icloud.com"])
        mainViewController.navigationBar.tintColor = UIColor.whiteColor()
        self.presentViewController(mainViewController, animated: true,completion:nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue{
            
        case MFMailComposeResultCancelled.rawValue:
         bottomMessageLabel.text = "Ohh! You cancelled that."
            
        case MFMailComposeResultSaved.rawValue:
            bottomMessageLabel.text = "Mail got saved in Draft."

        case MFMailComposeResultSent.rawValue:
            bottomMessageLabel.text = "Thanks for contacting me."

            
        case MFMailComposeResultFailed.rawValue:
            bottomMessageLabel.text = "Sending Failed!"

        default:
            break;
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    private func openURL(){
        performSegueWithIdentifier("ShowWebView", sender: nil)
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowWebView" {
            let destinationVC = segue.destinationViewController as! WebViewViewController
            destinationVC.url = urlString
            destinationVC.titleString = titleString
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
