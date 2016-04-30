
import UIKit

class AboutTableViewController: UITableViewController {

    //MARK: Table Data Array
    private let tableData = ["A Brief Introduction",
                             "Hi! I am Pawanpreet Singh. I am 22 years old, App and Web Developer from Patiala,India. I have done my schooling from Sri Aurobindo International School,Patiala. Presently, I am pursuing my Bachelor's degree from Punjabi University,Patiala.",
                             "selfie",
                             "I was introduced to the world of PCs in the early 2000s and my father bought me my own PC in 2002. In the beginning I was very well impressed my this wondrous machine by working on Paint and FoxPro. Later on at age of 15 with the introduction of coding at school, I began learning by my own which marked the end of my Gaming arena and beginning of the Coding phase. With few tags I could make my own webpages and show it to my mates.",
                             "steveJobs",
                             "My idol is Mr. Steven Paul Jobs. I had always dreamt of meeting him but unfortunately I couldn't. He inspired me and stimulated in me the dream of working for Apple one day. I follow his ideology, work principles and passion towards making things awesome."]
    
    private struct CellIdentifiers {
        static let HeaderCell = "HeaderCell"
        static let ImageCell = "ImageCell"
        static let TextCell = "TextCell"
    }
    
    
    //MARK : Variables
    private let tableHeaderHeight : CGFloat = 300.0
    private var headerView:HeaderView!
    private let tableHeaderCutAway: CGFloat = 80.0
    private var headerMaskLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("about Me",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AboutTableViewController.didRotate(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        headerView = tableView.tableHeaderView as! HeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        headerView.layer.mask = headerMaskLayer
        
        updateHeaderView()
    }
    
    // Function to Set and Update the Header View according to the bounds of the table and Making cut out.
    func updateHeaderView() {
        let effectiveHeight = tableHeaderHeight - tableHeaderCutAway / 2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height - tableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
        
    }

     func didRotate(notification: NSNotification){
        updateHeaderView()
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.HeaderCell, forIndexPath: indexPath)
            
            cell.textLabel?.text = "About Me"
            cell.detailTextLabel?.text = tableData[indexPath.row]
            
            return cell
        case 2,4:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.ImageCell, forIndexPath: indexPath) as! OnlyImageTableViewCell
            
            cell.galleryImageView.image = UIImage(named: tableData[indexPath.row])
            
            return cell
                    
            
        default:
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TextCell, forIndexPath: indexPath)

        cell.textLabel?.text = tableData[indexPath.row]

        return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
            
        case 2,4:
            return 300
            
        default:
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
            
        }
    }
  
    // Function for Parallax effect on Images
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
        let offsetY = self.tableView.contentOffset.y
        for singleCell in self.tableView.visibleCells {
            if singleCell.reuseIdentifier == CellIdentifiers.ImageCell{
                let cell = singleCell as! OnlyImageTableViewCell
                let x = cell.galleryImageView.frame.origin.x
                let w = cell.galleryImageView.bounds.width
                let h = cell.galleryImageView.bounds.height
                let y = ((offsetY - cell.frame.origin.y) / h) * 45
                cell.galleryImageView.frame = CGRectMake(x, y, w, h)
                
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}