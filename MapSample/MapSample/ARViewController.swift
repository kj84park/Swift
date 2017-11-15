//
//  ARViewController.swift
//  MapSample
//
//  Created by mac on 2017. 11. 14..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation

class ARViewController: UIViewController {
    
    var annotationCoorinate: CLLocationCoordinate2D!
    var sceneLocationView = SceneLocationView()
    
     var infoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneLocationView.run()
        
        print("## viewDidLoad")
        let location = CLLocation(coordinate: annotationCoorinate, altitude: 30)
        let image = UIImage(named: "pin")!
        let annotationNode = LocationAnnotationNode(location: location, image: image)
        annotationNode.scaleRelativeToDistance = true;
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        view.addSubview(sceneLocationView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sceneLocationView.pause()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
