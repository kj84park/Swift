//
//  ViewController.swift
//  Recognizer
//
//  Created by mac on 2017. 4. 18..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func tapDetected(_ sender: UITapGestureRecognizer) {
        statusLabel.text = "Double Tab을 감지"
    }
    
    @IBAction func pinchDetected(_ sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        let velocity = sender.velocity
        let resultString = "Pinch - scale : \(scale), velocity : \(velocity)"
        
        
        statusLabel.text = resultString
    }
    
    @IBAction func rotationDetected(_ sender: UIRotationGestureRecognizer) {
        
        let radians = sender.rotation
        let velocity = sender.velocity
        let resultString =
        "Rotation - radiands : \(radians), velocity : \(velocity)"
        
        statusLabel.text = resultString
    }
    
    @IBAction func swipeDetected(_ sender: UISwipeGestureRecognizer) {
        statusLabel.text = "swipeDetected"
    }
    @IBAction func longPassDetected(_ sender: UILongPressGestureRecognizer) {
        statusLabel.text = "longPassDetected"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

