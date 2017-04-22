//
//  ViewController.swift
//  MapSample
//
//  Created by papasmf1 on 2016. 10. 31..
//  Copyright © 2016년 mulcampus. All rights reserved.
//
import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    var matchingItems:[MKMapItem] = [MKMapItem]()
        @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func textReturn(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
    }
    @IBOutlet var searchText: UITextField!

    @IBAction func zoomIn(_ sender: AnyObject) {
        
        //사용자가 줌 버튼을 누르면 현재의 위치를 지도의 가운데로 위치시키고
        //영역 폭을 2000미터로 변경한다.
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
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
        // Do any additional setup after loading the view, typically from a nib.
        mapView.showsUserLocation = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performSearch(){
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
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
                    self.mapView.addAnnotation(annotation)
                    
                    
                }
            }
        })}
    
    
}

