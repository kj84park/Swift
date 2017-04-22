//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by mac on 2017. 4. 20..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    let managedobjectContext = (UIApplication.shared.delegate
    as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var status: UILabel!
    
    
    @IBAction func saveContact(_ sender: Any) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Contacts", in: managedobjectContext)
        
        let contact = Contacts(entity: entityDescription!, insertInto: managedobjectContext)
        
        contact.name = name.text!
        contact.address = address.text!
        contact.phone = phone.text!
        do {
            try managedobjectContext.save()
            name.text = ""
            address.text = ""
            phone.text = ""
            status.text = "Contacts saved"
        } catch let error{
            status.text = error.localizedDescription
        }
        
    }
    
    
    @IBAction func findContact(_ sender: Any) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Contacts", in: managedobjectContext)
        
        let request:NSFetchRequest<Contacts> = Contacts.fetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(name = %@)", name.text!)
        request.predicate = pred
        
        do {
            var results =
                try managedobjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                name.text = match.value(forKey: "name") as? String
                address.text = match.value(forKey: "address") as? String
                phone.text = match.value(forKey: "phone") as? String
                status.text = "Matches found: \(results.count)"
            } else {
                status.text = "No Match"
            }
        } catch let error {
            status.text = error.localizedDescription
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

