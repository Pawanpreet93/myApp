
import UIKit
import MapKit
import CoreMotion

class AcademicsTableViewController: UITableViewController {

    //MARK: Data Arrays
    private let tableData = ["Academic Life$1995-Present",
                             "It is rightly said that a person keeps on learning things everyday. Learning starts right from the moment when  we are in the mother's womb and continues till our death.  My academic journey started when I was 2.5 years old kid and after travelling a long road my journey of education is going to end this August (If I don't opt for Masters)",
                             "Sri Aurobindo International School$1995-2012",
                             "It was 1st April,1996 when my schooling started with a smile and excitement to learn something new along with everyone around me crying for being away from their parents. It was an astonishing journey which marked its end in 2012. ",
                             "30.338240$76.404003$My School$Sri Aurobindo International School",
                             "I was awarded with a student with Scientific Attitude and Leadership Qualities in the school. I was State level player of Yoga and participated in many Science Exhibitions.",
                             "adventure",
                             "Punjabi University$2012-Present",
                             "As already being told, I am currently pursuing my Bachelor's degree from Punjabi University, Patiala in Computer Engineering. It is 50 years old University and a home of First Cycling Track of India. College faculty has always been supportive. My teachers have always encouraged me to be a good programmer.",
                             "30.359330$76.444807$Computer Engineering Department$Punjabi University",
                             "At the University level, I founded a Technical club named \"Explogrammers\". My team has organised numerous coding events.  We have also launched India's First Technical Magazine by Students named \"E-Tech\". I have also hosted an iOS Development Workshop in my University. Apart from this I have also participated in a number of events and have won many.",
                             "aboutMe",
                             "My college journey was full of new experiences and developing new interests. Bachelor's degree will be marked as achieved in the coming August."]
    
    private struct CellIdentifiers {
        static let HeaderCell = "HeaderCell"
        static let ImageCell = "ImageCell"
        static let TextCell = "TextCell"
        static let MapCell = "MapCell"
    }
    //MARK: Variables
    private let tableHeaderHeight: CGFloat = 300.0
    private let tableHeaderCutAway: CGFloat = 80.0
    private var headerView: HeaderView!
    private var headerMaskLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AcademicsTableViewController.didRotate(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("academic Life",size: 20.0)
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
    
    func didRotate(notification: NSNotification)
    {
        updateHeaderView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

       
        switch indexPath.row {
        
            case 0 , 2, 7:
                
                let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.HeaderCell, forIndexPath: indexPath)
                
                let splitIntoArray = tableData[indexPath.row].characters.split{$0 == "$"}.map(String.init)
                
                cell.textLabel?.text = splitIntoArray[0]
                cell.detailTextLabel?.text = splitIntoArray[1]
                
                return cell
        
            
            case 4,9:
                
                let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.MapCell, forIndexPath: indexPath) as! MapTableViewCell
                
                let splitIntoArray = tableData[indexPath.row].characters.split{$0 == "$"}.map(String.init)
                
                let location = CLLocationCoordinate2DMake(Double(splitIntoArray[0])!, Double(splitIntoArray[1])!)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.003,longitudeDelta: 0.003)
                let region = MKCoordinateRegion(center: location, span: span)
                cell.mapView.setRegion(region, animated: true)
                
                cell.mapView.mapType = MKMapType.Satellite
                
                let annotation = MKPointAnnotation()
                annotation.title = splitIntoArray[2]
                annotation.subtitle = splitIntoArray[3]
                annotation.coordinate = location
                cell.mapView.addAnnotation(annotation)
                
                for eachAnnotation in cell.mapView.annotations{
                cell.mapView.selectAnnotation(eachAnnotation, animated: true)
                }
                return cell

            case 6,11:
                
                let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.ImageCell, forIndexPath: indexPath) as! OnlyImageTableViewCell
                cell.galleryImageView.image = UIImage(named:tableData[indexPath.row])
            
                return cell

            default:
            
                let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.TextCell, forIndexPath: indexPath)
                
                cell.textLabel?.text = tableData[indexPath.row]
                
                return cell

          
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
            
            case 0 , 2, 7:
                return 75
      
        case 4,9:
            return 230
            
                 case 6,11:
                return 300
      
            default:
                tableView.rowHeight = UITableViewAutomaticDimension
                return tableView.rowHeight
      
    }
}
    
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
