//
//  Contacts+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by mac on 2017. 4. 20..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?

}
