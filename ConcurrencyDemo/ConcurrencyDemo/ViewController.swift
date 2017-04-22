//
//  ViewController.swift

import UIKit

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
                 "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
                 "http://www.planetware.com/photos-large/SEY/best-tropical-vacations-bora-bora.jpg",
                 "http://www.planetware.com/photos-large/USKS/wichita-attractions-botanica-wichita.jpg"]


class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    var queue = OperationQueue()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickOnStart(sender: AnyObject) {
        
//        DispatchQueue.global().async {
//            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
//            DispatchQueue.main.async {
//            self.imageView1.image = img1
//            }
//
//        }
//        
//        DispatchQueue.global().async {
//            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
//            DispatchQueue.main.async {
//                self.imageView2.image = img2
//            }
//            
//        }
//        
//        DispatchQueue.global().async {
//            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
//            DispatchQueue.main.async {
//                self.imageView3.image = img3
//            }
//            
//        }
//        
//        DispatchQueue.global().async {
//            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
//            DispatchQueue.main.async {
//                self.imageView4.image = img4
//            }
//            
//        }
        
        //2)두번째 데모 : 순차적인 처리 (시리얼형태)
//        let serialQueue = DispatchQueue(label: "com.mulcam.imagesQueue")
//        serialQueue.async {
//            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
//            DispatchQueue.main.async {
//                self.imageView1.image = img1
//            }
//        }
//        
//        serialQueue.async {
//            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
//            DispatchQueue.main.async {
//                self.imageView2.image = img2
//            }
//        }
//        
//        serialQueue.async {
//            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
//            DispatchQueue.main.async {
//                self.imageView3.image = img3
//            }
//        }
//        
//        serialQueue.async {
//            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
//            DispatchQueue.main.async {
//                self.imageView4.image = img4
//            }
//        }

        //3)OpeationQueue를 사용
        queue.addOperation {
            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
            OperationQueue.main.addOperation {
                self.imageView1.image = img1
            }
        }
        
        queue.addOperation {
            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
            OperationQueue.main.addOperation {
                self.imageView2.image = img2
            }
        }
        
        queue.addOperation {
            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
            OperationQueue.main.addOperation {
                self.imageView3.image = img3
            }
        }
        
        queue.addOperation {
            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
            OperationQueue.main.addOperation {
                self.imageView4.image = img4
            }
        }
        
        
        
//        let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
//        self.imageView2.image = img2
//
//        let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
//        self.imageView3.image = img3
//        
//        let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
//        self.imageView4.image = img4
        
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }

}

