
import UIKit
import MapKit
import ARCL

extension UIImage {
    class func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

class ViewController: UIViewController, MKMapViewDelegate {
    var matchingItems:[MKMapItem] = [MKMapItem]()
    @IBOutlet weak var mapView: MKMapView!
    
    static var yyValue: Double! = 20000;
    static var xxValue: Double! = 20000;

    var annotationArray = [LocationNode]()
    
    var places = [Place]()
    var searchResultsPlaces = [Place]()
    var selectedAnnotation: MKPointAnnotation?
    
    @IBAction func textReturn(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch(placeForQuery:searchText.text!)
    }
    @IBOutlet var searchText: UITextField!

    @IBAction func showARMode(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ARViewController {
                destination.annotationArray = annotationArray
        }
    }
    
    @IBAction func zoomIn(_ sender: AnyObject) {
        
        //사용자가 줌 버튼을 누르면 현재의 위치를 지도의 가운데로 위치시키고
        //영역 폭을 2000미터로 변경한다.
        ViewController.xxValue = ViewController.xxValue / 5;
        ViewController.yyValue = ViewController.yyValue / 5;
        
        if(ViewController.xxValue < 10 || ViewController.yyValue < 10){
            ViewController.xxValue = 10;
            ViewController.yyValue = 10;
        }
        
        print("+ xx value : \(ViewController.xxValue)   yy : \(ViewController.xxValue)");
        
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, ViewController.xxValue, ViewController.yyValue)
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func scanMap(_ sender: UIBarButtonItem) {
        
        print("## scanMap")
        mapView.removeAnnotations(mapView.annotations)
        for place in self.places {
            performSearch(placeForQuery: place.title)
        }
        
    }
    @IBAction func ZoomOut(_ sender: Any) {
        
        ViewController.xxValue = ViewController.xxValue * 5;
        ViewController.yyValue = ViewController.yyValue * 5;
        
        if(ViewController.xxValue > 500000 || ViewController.yyValue > 500000){
            ViewController.xxValue = 500000;
            ViewController.yyValue = 500000;
        }
        
        print("- xx value : \(ViewController.xxValue)   yy : \(ViewController.xxValue)");
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, ViewController.xxValue, ViewController.yyValue)
        mapView.setRegion(region, animated: true)
        
    }
    @IBAction func changeMapType(_ sender: AnyObject) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
        } else {
            mapView.mapType = MKMapType.standard
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.showsPointsOfInterest = true
        mapView.showsTraffic = true
        mapView.delegate = self;
        mapView.setUserTrackingMode(MKUserTrackingMode.follow , animated: true)
        getPointOfList()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    @IBOutlet var distanceToDestination: UITextField!
    @IBOutlet var phoneNum: UITextField!
    @IBOutlet var expectedTime: UITextField!
    
    private func setupRouteInfo(view: MKAnnotationView) {
        
        let sourcePM = MKPlacemark(coordinate: mapView.userLocation.coordinate)
        let destinationPM = MKPlacemark(coordinate: view.annotation!.coordinate)

        let sourceMapItem = MKMapItem(placemark: sourcePM)
        let destinationMapItem = MKMapItem(placemark: destinationPM)
        
        // draw stuff
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            //draw line
            if let response = response {
                let route = response.routes[0]
                self.mapView.add(route.polyline, level: .aboveRoads)
                let distance = route.distance / 1000
                let result = String(format: "%.1f", distance)
                self.distanceToDestination.text = "\(result) KM"
                
                let interval = route.expectedTravelTime
                let componentFormatter = DateComponentsFormatter()
                componentFormatter.unitsStyle = .positional
                componentFormatter.zeroFormattingBehavior = .dropAll
                
                if let formattedString = componentFormatter.string(from: route.expectedTravelTime) {
                    self.expectedTime.text = "car "+formattedString
                }
                
                let routeRect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(routeRect), animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("## Annotation selected!!! : \(view.annotation!.title!) )");
        mapView.removeOverlays(mapView.overlays)
        for item in matchingItems{
            if(item.name == view.annotation!.title!){
                self.phoneNum.text = item.phoneNumber
                print("phone : \(item.phoneNumber)")
            }
        }
        setupRouteInfo(view: view);
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         print("## overlay!!!");
        let render = MKPolylineRenderer(overlay: overlay)
        render.lineWidth = 4.0
        render.strokeColor = UIColor.red
        return render
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("## Annotation didDeselect!!!");
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("## Annotation calloutAccessoryControlTapped!!!");
    }
    
    
    func getPointOfList() {
        if let path = Bundle.main.path(forResource: "categories", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    if let json = try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? [String: AnyObject]
                    {
                        let experts = json["pois"] as? [String]
                        
                        for category in experts! {
                            
                            let place = Place()
                            place.title = category
                            
                            self.places.append(place)
                            print("## search result : \(place.title)")
                        }
                        self.searchResultsPlaces = self.places
                    }
                } catch {
                    print("error in JSONSerialization")
                }
                
            } catch {}
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performSearch(placeForQuery: String){
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = placeForQuery
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response,error) in
            if error != nil{
                print("Error: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0{
                print("No matched found")
            } else {
                print("Matched found")
                for item in response!.mapItems {
                    if let name = item.name {
                        print("name = \(name)")
                        
                    }
                    
                    if let phone = item.phoneNumber {
                        print("phone = \(phone)")
                    }
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("matching items = \(self.matchingItems.count)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    
                    let location = CLLocation(coordinate: item.placemark.coordinate, altitude: 30)
                    //let image = UIImage(named: "pin")!
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    label.text = item.name
                    label.textColor = UIColor.white
                    let image = UIImage.imageWithLabel(label: label)
                    let annotationNode = LocationAnnotationNode(location: location, image: image)
  
                    //annotationNode.scaleRelativeToDistance = true;
                    self.annotationArray.append(annotationNode)
                  
                    self.mapView.addAnnotation(annotation)
                }
            }
        })}
}

