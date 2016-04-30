
import UIKit

class AimTableViewController: UITableViewController {

    //MARK: Data Array
    private let tableData = ["Dream Big",
                             
                             "At the age of 15, I entered the realm of coding. I spent hours learning new things. In the 8th standard, I decided to do Computer Engineering after my school education. After that there was no looking back. I always create short term goals and aim to fulfill them.\n\nTalking about my long term goals, being a social work lover, me and my friend have planned of making a free multi-speciality hospital only for poor people in my city. Now about my field that is Development, I have aimed to involve people from the Slum area, make them learn and be employed. I feel that if a person is having a good skill set and good logic building then he/she can develop anything and you never know that can be the Next Steve Jobs!!",
                             
                             "aimPic",
                             
                             "Working on my dream, I celebrated my 21st birthday by spending time in slums and helped them in realising the importance of education. I also participated in Technical Fest to raise funds and with that I adopted 4 orphans and now I funded their study and schooling expenditure for two years.\n\nDescribing a bit more about me is my \"daily goal setting\" habit. This includes making someone around me happy or at least make them smile. I would like you to be part of this campaign. Tap below and smile please!!😄"
    ]
    
    private struct CellIdentifiers {
        static let HeaderCell = "HeaderCell"
        static let ImageCell = "ImageCell"
        static let TextCell = "TextCell"
        static let NextScreenCell = "NextScreenCell"
    }
    
    // MARK: Variables
    private let tableHeaderHeight : CGFloat = 300.0
    private var headerView:HeaderView!
    private let tableHeaderCutAway: CGFloat = 80.0
    private var headerMaskLayer: CAShapeLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("my Aim",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
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

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.HeaderCell, forIndexPath: indexPath)
            
            cell.textLabel?.text = "Aim"
            cell.detailTextLabel?.text =  tableData[indexPath.row]
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.ImageCell, forIndexPath: indexPath) as! OnlyImageTableViewCell
            cell.galleryImageView.image = UIImage(named: tableData[indexPath.row])
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.NextScreenCell, forIndexPath: indexPath)
            return cell

        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TextCell, forIndexPath: indexPath)
            cell.textLabel?.text = tableData[indexPath.row]
            return cell
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
            
        case 2:
            return 300
        case 4:
            return 78
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
                let y = ((offsetY - cell.frame.origin.y) / h) * 65
                cell.galleryImageView.frame = CGRectMake(x, y, w, h)
                
            }
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}