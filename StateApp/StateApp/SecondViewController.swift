//
//  SecondViewController.swift
//  StateApp
//
//  Created by mac on 2017. 4. 18..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        thirdViewController = ThirdViewController(nibName: "ThirdViewController", bundle: nil)
    }
    var thirdViewController:UIViewController?
    
    @IBAction func clickButton(_ sender: Any) {
        //코드를 통해 뷰를 전환
        self.navigationController?.pushViewController(thirdViewController!, animated: true)
        
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(textView.text, forKey:"UnsavedText")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let codededObj = coder.decodeObject(forKey: "UnsavedText")
        {
            textView.text = codededObj as! String
        }
        super.decodeRestorableState(with: coder)
    }
    
    
    @IBOutlet weak var textView: UITextView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

