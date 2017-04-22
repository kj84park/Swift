//
//  Customer.swift
//  MyComp
//
//  Created by mac on 2017. 4. 17..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit
//외부 프로젝트에서 접근할 수 있도록 추가

open class Customer: NSObject {
    fileprivate var id = 0
    fileprivate var name = ""
    //게터 (읽기작업) 세터 (쓰기작업)
    open var ID:Int {
        get {return id}
        set {id = newValue}
    }
    
    open var Name:String{
        get {return name}
        set {name = newValue}
    }
    
    public init(id:Int,name:String){
        
        //생성자 메서드
        self.id = id
        self.name = name
    }
}
