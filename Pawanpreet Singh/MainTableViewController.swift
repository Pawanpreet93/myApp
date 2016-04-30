
import UIKit

class MainTableViewController:UITableViewController {
    
    // MARK: Data Arrays
    private let backgroundImages = [UIImage(named:"trackPic"),
                            UIImage(named:"personalLifeHomeImage"),
                            UIImage(named:"academicsHomeImage"),
                            UIImage(named:"codeAffairHomeImage"),
                            UIImage(named:"whyWWDCHomeImage"),]
    
    private let titleArray = ["pawanpreet Singh", "personal Life", "academic Life", "code Affair","why WWDC" ]
   
    private let overlayTintColors = [Colors.blueTintColor,Colors.yellowTintColor, Colors.brownTintColor, Colors.grayTintColor,Colors.grayTintColor]
   
    private var cellShown = [Bool](count:5, repeatedValue:false)

    private let cellIdentifier = "MainCell"
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor =  Colors.blackish
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString(titleArray[0],size: 20.0)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MainTableViewCell

        cell.backImageView.image = backgroundImages[indexPath.row]
            
        cell.titleLabel.attributedText = AtributedTitleText.MakeAtributedTitleString( titleArray[indexPath.row],size: 30.0)
        
        cell.overlayView.backgroundColor = overlayTintColors[indexPath.row]
        
                return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return tableView.frame.size.height - (navigationController?.navigationBar.frame.height)!
        }
        else {
            return 350
        }
    }
    
    // MARK: Function for Parallax Effect
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = self.tableView.contentOffset.y
        for cell in self.tableView.visibleCells as! [MainTableViewCell] {
            let x = cell.backImageView.frame.origin.x
            let w = cell.backImageView.bounds.width
            let h = cell.backImageView.bounds.height
            let y = ((offsetY - cell.frame.origin.y) / h) * 55
            cell.backImageView.frame = CGRectMake(x, y, w, h)
        }
    }
    
    // MARK: Segue on Row Select
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
            
        case 0:
            performSegueWithIdentifier("GeneralSegue", sender: nil)
        case 1:
            performSegueWithIdentifier("PersonalLifeSegue", sender: nil)
        case 2:
            performSegueWithIdentifier("ShowAcademicsSegue", sender: nil)
        case 3:
            performSegueWithIdentifier("ShowCodeSegue", sender: nil)
        default:
            performSegueWithIdentifier("ShowWWDCSegue", sender: nil)

        }
    }
  
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
