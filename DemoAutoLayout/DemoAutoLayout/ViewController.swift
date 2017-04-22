//
//  ViewController.swift
//  DemoAutoLayout
//
//  Created by mac on 2017. 4. 17..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        
        //4방향을 모두 지원
        return UIInterfaceOrientationMask.all
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

