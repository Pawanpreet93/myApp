
import UIKit

class CodeTableViewController: UITableViewController {

    // MARK: Table Data Arrays
    private let tableData = ["Code Affair$7 years of Happiness",
                             
                             " I was introduced to programming language at the age of 15 when I was in 8th standard. After that it was no looking back. In 2002 I got my first PC and I was in love with it. After my school I got My first Apple Product - MacBook Pro as a gift and after that I cant imagine my life without Apple Product (its more like an Apple obsession now!!). The following timeline will tell you about my journey of learning programming languages.",
                             
                             "Languages Timeline$Never ending Learning",
                             
                             "HTML$With this knowledge,I started developing webpages with the guidance of my school teacher and used those to tease my sister and be hero in front of my friends.",
                             
                             "C and C++$This was the first language that made me fall for the programming. On the first day itself I bought books and started learning them. I developed simple games like tic tac toe with the help of  this.",
        
                             "Objective C$The time I got my MacBook Pro, I thought to utilize it do develop iOS Apps and for that I started learning it from the YouTube videos and using Apple Developer portal. I never had any coaching of this. And later on I resoluted to build my career as an iOS App Developer.",
        
                             "C#$For the Summer Internship due to lack of any iOS app development company around me I opted for C# and ended up being Microsoft Certified Professional and Microsoft Technology Associate.",
        
                             "CSS$Working on one of my projects I learnt this to beautify my pages.",
        
                             "Swift$After being introduced to App developers in 2014 I just dropped Objective C and started learning Swift. It was fun learning it on Playground.",
        
                             "JS$I started learning this as a part time in my internship to connect UI of website to their backend.",
                             
                             "code$know More",
                             
                             "Projects$Some Highlights",
                             
                             "Now about the projects, from the age of 15, I used to practice in building Webpages and used to tease my elder sister. Then after I started my undergraduate degree, I used to work on real world applications stated below.",
                             
                             "Telephone Directory$Developed using C++ and allowing the user to add,update, delete and Search the directory of contact numbers and addresses.",
       
                             "eDoctor$A website developed using .NET framework along with MS SQL Server that allows user to search a specialist doctor in its vicinity.",
       
                             "C Questions$An iOS App created using Objective C. It is a basic quiz app covering some important topics of C language along with the answers. It also has cloud database for storing errors and feedbacks submitted by user.",
      
                             "Data Structures$Built using Swift language and is also supported on Apple Watch which helps the user to learn Data structure in a very innovative and step by step manner using gestures.",
        
                             " Clenergize$Developed iPhone and iPad apps for my Friend's startup.",
        
                             "Data Structures Step by Step$Windows version of Data Structures iOS App.",
                             
                             "projects$app Store"]
    
    private struct CellIdentifiers {
        static let HeaderCell = "HeaderCell"
        static let TimelineHeaderCell = "TimelineHeaderCell"
        static let TimelineCell = "TimelineCell"
        static let TimelineFooterCell = "TimelineFooterCell"
        static let TintImageCell = "TintImageCell"
        static let TextCell = "TextCell"
    }
    
    // MARK: Variables
    private let tableHeaderHeight: CGFloat = 300.0
    private let tableHeaderCutAway: CGFloat = 80.0
    private var headerView: HeaderView!
    private var headerMaskLayer: CAShapeLayer!
    
    // MARK: - Default Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CodeTableViewController.didRotate(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("code Affair",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tableData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0,2,11:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.HeaderCell, forIndexPath: indexPath)
            
            let splitIntoArray = tableData[indexPath.row].characters.split{$0 == "$"}.map(String.init)

            cell.textLabel!.text = splitIntoArray[0]
            cell.detailTextLabel!.text = splitIntoArray[1]
            
            return cell
            
            
        case 3,13:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TimelineHeaderCell, forIndexPath: indexPath) as! TimelineTableViewCell
            
            let splitIntoArray = tableData[indexPath.row].characters.split{$0 == "$"}.map(String.init)

            cell.titleLabel.text = splitIntoArray[0]
            cell.descLabel.text = splitIntoArray[1]
            
            return cell
            
        case 4...8,14...17:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TimelineCell, forIndexPath: indexPath) as! TimelineTableViewCell
            
            let splitIntoArray = tableData[indexPath.row].characters.split{$0 == "$"}.map(String.init)

            cell.titleLabel.text = splitIntoArray[0]
            cell.descLabel.text = splitIntoArray[1]
            
            return cell
            
        case 9,18:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TimelineFooterCell, forIndexPath: indexPath) as! TimelineTableViewCell
            
            let splitIntoArray = tableData[indexPath.row].characters.split{$0 == "$"}.map(String.init)

            cell.titleLabel.text = splitIntoArray[0]
            cell.descLabel.text = splitIntoArray[1]
            
            return cell
            
        case 10,19:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TintImageCell, forIndexPath: indexPath) as! ImageTintLabelTableViewCell
            
            let splitIntoArray = tableData[indexPath.row].characters.split{$0 == "$"}.map(String.init)

            cell.backImageView.image = UIImage(named:splitIntoArray[0])
            cell.overlayTintView.backgroundColor = Colors.darkGrayTintColor
            cell.titleLabel.attributedText = AtributedTitleText.MakeAtributedTitleString(splitIntoArray[1], size: 50.0)
            
            return cell
            

            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TextCell, forIndexPath: indexPath)
            
           cell.textLabel?.text = tableData[indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0,2,11:
            return 70
        case 10,19:
            return 300
        default:
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 10{
            performSegueWithIdentifier("ShowLanguagesSegue", sender: nil)
        }
        if indexPath.row == 19{
            performSegueWithIdentifier("ShowMyAppsSegue", sender: nil)
        }
        
    }

    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()

        let offsetY = self.tableView.contentOffset.y
        for singleCell in self.tableView.visibleCells {
                      if singleCell.reuseIdentifier == CellIdentifiers.TintImageCell{
                let cell = singleCell as! ImageTintLabelTableViewCell
                let x = cell.backImageView.frame.origin.x
                let w = cell.backImageView.bounds.width
                let h = cell.backImageView.bounds.height
                let y = ((offsetY - cell.frame.origin.y) / h) * 40
                cell.backImageView.frame = CGRectMake(x, y, w, h)
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
