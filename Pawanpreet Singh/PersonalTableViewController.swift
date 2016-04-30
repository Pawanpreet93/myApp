
import UIKit

class PersonalTableViewController: UITableViewController {

    //MARK: Data Arrays
    private let titleArray = ["A B O U T   M E", "A I M", "I N T E R E S T S","H O M E","S C H E D U L E"]
    
    private let iconImages = [UIImage(named:"about"),
                              UIImage(named:"target"),
                              UIImage(named:"interest"),
                              UIImage(named:"map"),
                              UIImage(named:"schedule")]
    
   private let backgroundColors = [Colors.cellBackgroundCyan,Colors.cellBackgroundOrange,Colors.cellBackgroundGreen, Colors.cellBackgroundPink,Colors.cellBackgroundPurple]
    
      private  var cellShown = [Bool](count:5, repeatedValue:false)
    
    private let cellIdentifier = "PersonalCell"
    
    //MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor =  Colors.blackish
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("personal Life",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PersonalTableViewCell

        cell.titleLabel.text = titleArray[indexPath.row]
        cell.iconImage?.image = iconImages[indexPath.row]
        cell.backgroundColor = backgroundColors[indexPath.row]
        
        if !cellShown[indexPath.row]{
        cell.titleLabel.transform = CGAffineTransformMakeScale(0, 0)
        cell.iconImage?.transform = CGAffineTransformMakeScale(0, 0)
        cell.arrowImage.alpha = 0
            
        UIView.animateWithDuration(0.4, delay: Double(indexPath.row)*0.4, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            cell.titleLabel.transform = CGAffineTransformMakeScale(1.3, 1.3)
            cell.iconImage?.transform = CGAffineTransformMakeScale(1.3, 1.3)
            
            cell.titleLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
            cell.iconImage?.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            cell.arrowImage.alpha = 1
            
            }, completion: nil)
            
            cellShown[indexPath.row] = true
        }
        
        return cell
    }

    //MARK: Segue on Row select
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row{
        case 0:
            performSegueWithIdentifier("ShowAboutSegue", sender: nil)
        case 1:
            performSegueWithIdentifier("ShowAimSegue", sender: nil)
        case 2:
            performSegueWithIdentifier("ShowInterestsSegue", sender: nil)
        case 3:
            performSegueWithIdentifier("ShowMapSegue", sender: nil)
        default:      //Schedule
            performSegueWithIdentifier("ShowScheduleSegue", sender: nil)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}