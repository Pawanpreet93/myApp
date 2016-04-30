
import UIKit

class MyAppsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("my Apps",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        let backgroundFooterView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = backgroundFooterView
        self.tableView.backgroundColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyAppsData.appNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyAppsCell", forIndexPath: indexPath) as! MyAppsTableViewCell

        cell.countLabel.text = "\(indexPath.row + 1)"
        
             cell.appNameLabel.text = MyAppsData.appNames[indexPath.row]
            cell.iconImageView.image = UIImage(named:MyAppsData.appIconImages[indexPath.row])
            cell.appStatus.setTitle(MyAppsData.appStatusTitles[indexPath.row], forState: UIControlState.Normal)
            
            if MyAppsData.appStatusTitles[indexPath.row] != "APP STORE"{
                cell.appStatus.backgroundColor = UIColor.redColor()
                cell.appStatus.layer.borderColor = UIColor.redColor().CGColor
                cell.appStatus.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                for eachStar in cell.ratingStars{
                    eachStar.hidden = true
                }
            }
            
            cell.categoryLabel.text = MyAppsData.appCategory[indexPath.row]
        
        if MyAppsData.ratingCount[indexPath.row] == 0 {
                cell.ratingCountLabel.hidden = true
            }
            else{
                cell.ratingCountLabel.text = "(\(MyAppsData.ratingCount[indexPath.row]))"
            }
        
    return cell

}

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! AppDetailTableViewController
        destinationVC.selectedApp = tableView.indexPathForSelectedRow!

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}
