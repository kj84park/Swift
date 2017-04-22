//
//  ViewController.swift
//  MyClient
//
//  Created by mac on 2017. 4. 17..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit
import MyComp

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //뷰의 로딩이 완료되면 실행
        let cust = Customer(id: 100, name: "전우치")
        print("\(cust.ID)","\(cust.Name)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

