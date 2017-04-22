//
//  ViewController.swift
//  DemoMapItem
//
//  Created by mac on 2017. 4. 21..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts
import MapKit

class ViewController: UIViewController {

    @IBOutlet var address: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var zip: UITextField!
    var coords:CLLocationCoordinate2D?
    
    @IBAction func getDirection(_ sender: Any) {
        let addressString = "\(address!.text) \(city!.text) \(state!.text) \(zip!.text)"
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks,error) in
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                self.coords = location!.coordinate
                self.showMap()
            }
        })
    }
    func showMap() {
        let addressDict =
            [CNPostalAddressStreetKey: address.text!,
             CNPostalAddressCityKey: city.text!,
             CNPostalAddressStateKey:state.text!,
             CNPostalAddressPostalCodeKey:zip.text!]
        
        let place = MKPlacemark(coordinate: coords!, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: place)
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: options)}
    
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

