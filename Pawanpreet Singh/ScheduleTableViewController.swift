
import UIKit
import QuartzCore

class ScheduleTableViewController: UITableViewController {

    private let textArray = ["My day starts with the alarm snoozing then with one sleepy eye I check the notifications like every youngster, followed by a 15 minutes meditation and leaving my bed with day all planned up, and then getting ready for the morning lectures.",
    "Afternoon gets going with the overhead sun, fighting with the scorching heat to reach home and analysing the lectures and homework.  It ends up with lunch and a little coding work.",
    "Evening marks its beginning with my cup of tea along with a novel followed by some more coding and then a walk and some exercising too. After flexing my muscles again it's time for setting my fingers on keyboard to work.",
    "Night begins with a dinner with family, some chit-chatting with them, followed by some with friends. After refreshing my mind it's time to learn some new things and checking out some tech news. At last I analyse my day by marking the progress of work."]
    
    private let images = [UIImage(named:"morning"),UIImage(named:"afternoon"),UIImage(named:"evening"),UIImage(named:"night")]
    
    private var cellShown = [Bool](count:11, repeatedValue:false)

    private let textColors = [Colors.yellowish,UIColor.orangeColor(),Colors.reddish,Colors.cyanish]
    
    private let CellIdentifier = "ScheduleCell"
    private let tableHeaderHeight : CGFloat = 300.0
    private var headerView:HeaderView!
    private let tableHeaderCutAway: CGFloat = 80.0
    private var headerMaskLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("daily Schedule",size: 20.0)
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
        return textArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! ScheduleTableViewCell
        
        cell.label.text = textArray[indexPath.row]
        cell.iconImage.image = images[indexPath.row]
        cell.label.textColor = textColors[indexPath.row]
        
        return cell
    }
    
  
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if !cellShown[indexPath.row] {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animateWithDuration(1, delay: 0, options: [.AllowUserInteraction, .CurveEaseInOut], animations: { () -> Void in
            view.layer.opacity = 1
            }, completion: nil)
          
            cellShown[indexPath.row] = !cellShown[indexPath.row]
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
