

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
        
        
        // queueWithDelay()
        
         fetchImage()
        
        // useWorkItem()
    }
    
    
    
    func simpleQueues() {
        //디스패치 큐
        let queue = DispatchQueue(label: "com.credu.myqueue")
        queue.async {
            for i in 0..<10{
                print("q",i)
            }
        }
        //큐의 바깥쪽에 코드 추가
        for i in 100..<110{
            print("m",i)
        }
    }
    
    
    func queuesWithQoS() {
        let queue1 = DispatchQueue(label: "com.credu.queue1", qos: DispatchQoS.background)
        let queue2 = DispatchQueue(label: "com.credu.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10{
                print("q",i)
            }

        }
        
        queue2.async {
            for i in 100..<110{
                print("m",i)
            }
            
        }
    }
    
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        let anotherQueue = DispatchQueue(label: "com.credu.anotherQueue",qos:.utility,attributes:[.concurrent,.initiallyInactive])
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10{
                print("q",i)
            }
            
        }
        
        anotherQueue.async {
            for i in 100..<110{
                print("m",i)
            }
            
        }
        
        anotherQueue.async {
            for i in 1000..<1010{
                print("w",i)
            }
            
        }
    }
    
    
    func queueWithDelay() {
        let delayQueue = DispatchQueue(label: "com.credu.delayqueue",qos:.userInitiated)
        
        print(Date())
        let additionalTime:DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now()+additionalTime){
            print("두번째 실행 :\(Date())")
        }
        
        delayQueue.asyncAfter(deadline: .now()+0.75){
            print("세번째 실행 :\(Date())")
        }
        
        
    }
    
    
    func fetchImage() {
        let imageURL: URL = URL(string:"http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        (URLSession(configuration: .default)).dataTask(with: imageURL,completionHandler:{
            (imageData, response,error) in
            if let data = imageData {
                print("Did download image data")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)

                }
            }
        }).resume()
    }
    
    
    func useWorkItem() {
        
    }
}

