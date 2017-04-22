//
//  ThirdViewController.swift
//  StateApp
//
//  Created by mac on 2017. 4. 18..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIViewControllerRestoration {

    //다른 언어에서의 정적 메서드를 뜻함
    class func viewController(withRestorationIdentifierPath
        identifierComponents:[Any], coder:NSCoder) -> UIViewController?{
    
        let myViewController = ThirdViewController(nibName: "ThirdViewController",bundle:nil)
        return myViewController;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restorationIdentifier = "thridViewController"
        self.restorationClass = ThirdViewController.self

        // Do any additional setup after loading the view.
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
