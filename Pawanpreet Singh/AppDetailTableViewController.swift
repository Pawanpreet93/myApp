
import UIKit

class AppDetailTableViewController: UITableViewController {

    var selectedApp  = NSIndexPath()
    var selectedCell  = NSIndexPath()
    var storedOffsets = [Int: CGFloat]()
    
    private struct CellIdentifiers {
        static let HeaderCell = "AppHeaderCell"
        static let iPhoneScreenshotsCell = "iPhoneScreenshotsCollectionViewCell"
        static let WatchScreenshotsCell = "WatchScreenshotsCollectionViewCell"
        static let DescriptionCell = "DescriptionCell"
        static let InformationCell = "InformationCell"
        static let CopyrightCell = "CopyrightCell"
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString(MyAppsData.headerAppNames[selectedApp.row],size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.HeaderCell, forIndexPath: indexPath) as! AppHeaderTableViewCell
            
            cell.appIconImage.image = UIImage(named: MyAppsData.appIconImages[selectedApp.row])
            cell.appNameLabel.text = MyAppsData.appNames[selectedApp.row]
            cell.developerNameLabel.text = "Pawanpreet Singh"
            
            if MyAppsData.appStatusTitles[selectedApp.row] != "APP STORE"{
                cell.appStatus.setTitle(MyAppsData.appStatusTitles[selectedApp.row], forState: UIControlState.Normal)
                cell.appStatus.backgroundColor = UIColor.redColor()
                cell.appStatus.layer.borderColor = UIColor.redColor().CGColor
                cell.appStatus.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                cell.appStatus.enabled = false
                for eachStar in cell.ratingStars{
                    eachStar.hidden = true
                }
            }else{
                    cell.appStatus.setTitle("OPEN", forState: UIControlState.Normal)
                    cell.appStatus.addTarget(self, action: #selector(AppDetailTableViewController.openButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                }
            
            
            if MyAppsData.ratingCount[selectedApp.row] == 0 {
                cell.ratingCountLabel.hidden = true
            }
            else{
                cell.ratingCountLabel.text = "(\(MyAppsData.ratingCount[selectedApp.row]))"
            }

            if MyAppsData.appNames[selectedApp.row] == "Data Structures"{
                cell.watchIconImage.image = UIImage(named: "dataStructureIcon")
                cell.watchLabel.text = "Offers Apple Watch App"
            }else{
                cell.watchLabel.hidden = true
                cell.watchIconImage.hidden = true
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.iPhoneScreenshotsCell, forIndexPath: indexPath)
            
            return cell

            
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.DescriptionCell, forIndexPath: indexPath) as! DescriptionTableViewCell
            
            cell.titleLabel?.text = "Description (Code)"
            cell.descriptionLabel?.text = MyAppsData.codeDescription[selectedApp.row]
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.DescriptionCell, forIndexPath: indexPath) as! DescriptionTableViewCell
            
            cell.titleLabel?.text = "Description (App)"
            cell.descriptionLabel?.text = MyAppsData.appDescription[selectedApp.row]
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.CopyrightCell, forIndexPath: indexPath)
            
            cell.textLabel?.text = "Copyright © \( MyAppsData.appCopyright[selectedApp.row])"
            
            return cell

        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.InformationCell, forIndexPath: indexPath) as! AppInformationTableViewCell
            
            cell.developerLabel.text = "Pawanpreet Singh"
            cell.categoryLabel.text = MyAppsData.appCategory[selectedApp.row]
            cell.updatedLabel.text = MyAppsData.appUpdatedOn[selectedApp.row]
            cell.versionLabel.text = MyAppsData.appVersion[selectedApp.row]
            cell.sizeLabel.text = MyAppsData.appSize[selectedApp.row]
            cell.ratingLabel.text = "4+"
            cell.familySharingLabel.text = "Yes"
            cell.compatibilityLabel.text = MyAppsData.appCompatibilty[selectedApp.row]
            cell.watchLabel.text = MyAppsData.appAppleWatch[selectedApp.row]
            cell.languagesLabel.text = "English"
            
            return cell

        }
        
    }
    
    func openButtonAction(sender:UIButton){
        let url = NSURL(string: MyAppsData.appLinks[selectedApp.row])
        UIApplication.sharedApplication().openURL(url!)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
            switch indexPath.row {
            
        case 0:
            if selectedApp.row == 0{
            return 145
            }
            else{
                return 120
            }
        case 1:
            return 330
        case 4:
            return 256
        default:
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
            }
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1{
            guard let tableViewCell = cell as? iPhoneScreenshotsTableViewCell else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        }
        
        
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.row == 1{
            guard let tableViewCell = cell as? iPhoneScreenshotsTableViewCell else { return }
            
            storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
            
        }
        
    }

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowScreenshotsSegue"{
            let destinationVC = segue.destinationViewController as! ScreenshotViewController
            destinationVC.selectedApp = selectedApp
            destinationVC.selectedCell = selectedCell
        }
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}



// MARK: - Extension for Collection View

extension AppDetailTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
              let cell = collectionView.dequeueReusableCellWithReuseIdentifier("iPhoneScreenshotCell", forIndexPath: indexPath) as! ScreenshotCollectionViewCell
        
        let imageName = MyAppsData.appNames[selectedApp.row] + "\(indexPath.row)"
        cell.imageView.image = UIImage(named: imageName)
        
        return cell
        
    }
    
    
        func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            selectedCell = indexPath
            performSegueWithIdentifier("ShowScreenshotsSegue", sender: nil)
        }
}
