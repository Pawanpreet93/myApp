
import UIKit
import MapKit
class MapPlaneViewController: UIViewController,MKMapViewDelegate {

    //MARK: Variables
    private var myMapView: MKMapView = MKMapView()
    private var planeAnnotation: MKPointAnnotation = MKPointAnnotation()
    private var planeAnnotationPosition: NSInteger = 0
    private var flightpathPolyline: MKGeodesicPolyline = MKGeodesicPolyline()
    private var myAnnotation: MKAnnotationView!
    private var isPlaneView = false
    
    // Outlets
    @IBOutlet weak var mapSwitchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("my Home",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
        myMapView.mapType = .Satellite
        viewSetup()
        setupHomeLocation()
        
    }
    
    // MARK: Setup Functions
    func viewSetup(){
        myMapView.frame = self.view.frame
        myMapView.center = self.view.center
        myMapView.delegate = self
    }
    
    func setupPlaneView(){
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(59.234627, 119.527327)
        
        myMapView.centerCoordinate = center
        
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
        
        myMapView.region = myRegion
        
        self.view.addSubview(myMapView)
        
        let appleLocation: CLLocation = CLLocation(latitude:37.331871, longitude:-122.029529)
        let myHome: CLLocation = CLLocation(latitude:30.370631, longitude:76.381854)
        
        var coordinate:[CLLocationCoordinate2D] = [myHome.coordinate, appleLocation.coordinate]
        
        flightpathPolyline = MKGeodesicPolyline(coordinates:&coordinate , count:2)
        
        myMapView.addOverlay(flightpathPolyline)
        
        planeAnnotation = MKPointAnnotation()
        let annotationView = MKAnnotationView()
        annotationView.image = UIImage(named:"plane")!
        annotationView.annotation = planeAnnotation
        myMapView.addAnnotation(planeAnnotation)
        
        updatePlanePosition()
        
    }
    
    func setupHomeLocation(){
        
        let location = CLLocationCoordinate2DMake(30.370631, 76.381854)
        let span = MKCoordinateSpan(latitudeDelta: 0.003,longitudeDelta: 0.003)
        let region = MKCoordinateRegion(center: location, span: span)
        myMapView.setRegion(region, animated: true)
                
        let annotation = MKPointAnnotation()
        let annotationView = MKAnnotationView()
        annotation.title = "My Home"
        annotation.subtitle = "370/3D Ekta Vihar, Patiala, Punjab"
        annotation.coordinate = location
        annotationView.image = UIImage(named:"location")!
        annotationView.annotation = annotation
        myMapView.addAnnotation(annotation)
        
        self.view.addSubview(myMapView)
        

    }
    
    @IBAction func mapSwitchButtonAction(sender: AnyObject) {
             isPlaneView = true
            setupPlaneView()
            mapSwitchButton.enabled = false
    }
    
    // MARK: Map Overlay
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        myPolyLineRendere.lineWidth = 5
        
        myPolyLineRendere.strokeColor = Colors.cellBackgroundGreen
        
        return myPolyLineRendere
    }
    
    // MARK: Plane View Functions
    func updatePlanePosition() {
        
        let step:NSInteger = 100
        
        if (planeAnnotationPosition + step >= flightpathPolyline.pointCount) {
            
            return;
            
        }
        
        let previousPolyLinePoints = flightpathPolyline.points()
        let previousMapPoint: MKMapPoint = previousPolyLinePoints[planeAnnotationPosition]
        
        planeAnnotationPosition += step
        
        let nextPolyLinePoints = flightpathPolyline.points()
        let nextMapPoint: MKMapPoint = nextPolyLinePoints[planeAnnotationPosition]
        
        let nextCoord: CLLocationCoordinate2D = MKCoordinateForMapPoint(nextMapPoint)
        
        let planeDirection = XXDirectionBetweenPoints(previousMapPoint, nextMapPoint: nextMapPoint)
        
        planeAnnotation.coordinate = nextCoord
        
        myAnnotation.transform = CGAffineTransformRotate(myMapView.transform, XXDegreesToRadians(planeDirection));
        
        let delay = 0.05 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            
            self.updatePlanePosition()
            
        })
        
    }
    
    func XXDirectionBetweenPoints(previousMapPoint: MKMapPoint, nextMapPoint: MKMapPoint) -> CLLocationDirection {
        let x: Double = nextMapPoint.x - previousMapPoint.x
        let y: Double = nextMapPoint.y - previousMapPoint.y
        
        return fmod(XXRadiansToDegrees(atan2(y, x)), 360.0) + 90.0
    }
    
    func XXRadiansToDegrees(radians: Double) -> Double {
        return radians * 180.0 / M_PI
    }
    
    func XXDegreesToRadians(degrees: Double) -> CGFloat {
        return CGFloat(degrees * M_PI / 180.0)
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let myIdentifier = "myPin"
        
        if myAnnotation == nil {
            myAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: myIdentifier)
        }
        
        if isPlaneView {
        myAnnotation.image = UIImage(named: "plane")!
        myAnnotation.annotation = annotation

        }
        else{
            myAnnotation.image = UIImage(named: "location")!
            myAnnotation.annotation = annotation

        }
        return myAnnotation
    }
    
    // Check Orientation Of Devices
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        viewSetup()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
