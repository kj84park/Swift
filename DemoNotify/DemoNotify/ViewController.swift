//
//  ViewController.swift
//  DemoNotify
//
//  Created by mac on 2017. 4. 20..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController , UNUserNotificationCenterDelegate{

    
    var messageSubtitle = "20분 후에 미팅이 있습니다."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //델리게이트 연결
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {(Granted,error) in
        
        
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //앱이 전면에 있을때 통보 받기
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    @IBAction func buttonPresed(_ sender: Any) {
        sendNotification()
    }
    
    func sendNotification()
    {
        let content = UNMutableNotificationContent()
        content.title = "미팅 리마인더"
        content.subtitle = messageSubtitle
        content.body = "커피를 꼭 지참하세요"
        content.badge = 1
        
        //추가 액션과 카테고리를 작성
        let repeatAction = UNNotificationAction(identifier: "repeat", title: "Repeat", options: [])
        
        let changeAction = UNNotificationAction(identifier: "change", title: "Change Message", options: [])
        
        let category = UNNotificationCategory(identifier: "actionCategory", actions: [repeatAction,changeAction], intentIdentifiers: [], options: [])
        
        content.categoryIdentifier = "actionCategory"
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        
        //트리거로 통보
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler: {(error) in
                //에러 처리
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

