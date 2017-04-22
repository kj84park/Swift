

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //simpleQueues()
        
        //queuesWithQoS()
        
        
//         concurrentQueues()
//         if let queue = inactiveQueue {
//            queue.activate()
//         }
        
        
//        queueWithDelay()
        
//         fetchImage()
        
         useWorkItem()
    }
    
    
    
    func simpleQueues() {
        let queue = DispatchQueue(label: "com.credu.myqueue")
        queue.async {
            for i in 0..<10 {
                print("q ", i)
            }
        }

        for i in 100..<110 {
            print("m", i)
        }
        
    }
    
    
    func queuesWithQoS() {
        
        let queue1 = DispatchQueue(label: "com.credu.queue1", qos: DispatchQoS.background)
        let queue2 = DispatchQueue(label: "com.credu.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10 {
                print("q", i)
            }
        }
        
        queue2.async {
            for i in 100..<110 {
                print("m", i)
            }
        }
        
    }
    
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        
        let anotherQueue = DispatchQueue(label: "com.credu.anotherQueue", qos: .utility,
                                         attributes: [.concurrent, .initiallyInactive])
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                print("q", i)
            }
        }
        
        anotherQueue.async {
            for i in 100..<110 {
                print("m", i)
            }
        }
        
        anotherQueue.async  {
            for i in 1000..<1010 {
                print("w", i)
            }
        }
    }
    
    
    func queueWithDelay() {
        let delayQueue = DispatchQueue(label: "com.credu.delayqueue", qos: .userInitiated)
        print(Date())
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
        
        delayQueue.asyncAfter(deadline: .now() + 0.75) {
            print(Date())
        }
    }
    
    
    func fetchImage() {
//        let globalQueue = DispatchQueue.global()
//        globalQueue.async {
//            for i in 0..<10 {
//                print("m", i)
//            }
//        }
        
        //let globalQueue = DispatchQueue.global(qos: .userInitiated)
        
        let imageURL: URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("Did download image data")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()

    }
    
    
    func useWorkItem() {
        var value = 10
        let workItem = DispatchWorkItem {
            value += 5
        }
        workItem.perform()
        
        let queue = DispatchQueue.global()
        queue.async {
            workItem.perform()
        }
        
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
        
    }
}

