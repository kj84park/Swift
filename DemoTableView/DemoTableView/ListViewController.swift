//
//  ListViewController.swift
//  DemoTableView
//
//  Created by mac on 2017. 4. 19..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var list = Array<User>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URL 주소
        
        let apiURI = URL(string: "https://randomuser.me/api/?results=20")
        var apiData:Data?
        
        do{
            try apiData = Data(contentsOf: apiURI!)
            
        } catch {
            
        }
        
        let string = String(data: apiData!, encoding: .utf8)
        print("API Result = \(String(describing: string))")
        
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apiData!, options:.allowFragments) as! NSDictionary
            
            let users = apiDictionary["results"] as! [AnyObject]
            
            var user:User
            for row in users {
                user = User()
                print("row : \(row)")
                let nameDict = row["name"]  as? NSDictionary
                user.lastName = nameDict?["last"] as? String
                user.firstName = nameDict?["first"] as? String
                let locationDict = row["location"] as? NSDictionary
                user.street = nameDict?["street"] as? String
                user.cell = row["cell"] as? String
                
                let picDict = row["picture"] as? NSDictionary
                user.picture = picDict?["large"] as? String
                
                self.list.append(user)
                
                
            }
        }   catch{
            
        }
        
        
        
        //        var user = User()
        //        user.firstName = "길동"
        //        user.lastName = "홍"
        //        user.street = "역삼역"
        //        user.cell = "010-123-1234"
        //        user.picture = "avengers.jpg"
        //        self.list.append(user)
        //
        //        user = User()
        //        user.firstName = "우치"
        //        user.lastName = "전"
        //        user.street = "강남역"
        //        user.cell = "010-222-1234"
        //        user.picture = "darkknight.jpg"
        //
        //        self.list.append(user)
        //
        //        user = User()
        //        user.firstName = "문수"
        //        user.lastName = "박"
        //        user.street = "선릉역"
        //        user.cell = "010-333-1234"
        //        user.picture = "thor.jpg"
        //
        //        self.list.append(user)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //그룹의 갯수를 리턴
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //그룹의 셀의 갯수
        return self.list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        print("result=\(row.lastName!), row index= \(indexPath.row)")
        
        //다운 캐스팅(UITableViewCell => UserCell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! UserCell
        
        
        // Configure the cell...
        //        cell.textLabel?.text = row.lastName
        //        cell.detailTextLabel?.text = row.firstName
        
        //커스텀셀을 사용한 출력
        cell.lastName?.text = row.lastName
        cell.firstName?.text = row.firstName
        cell.street?.text = row.street
        cell.cellPhone?.text = row.cell
        
        //이미지뷰에출력
        //비동기 방식으로 처리(다중쓰레드)
        DispatchQueue.main.async(execute: {
            print("비동기로 실행되는 코드입니다.")
            cell.thumbnail.image = self.getThumbnailImage(index: indexPath.row)
        })
        print("셀 생성을 종료합니다.")
        
       // cell.thumbnail.image = UIImage(named: row.picture!)
        return cell
    }
    
    func getThumbnailImage(index:Int) -> UIImage {
        let user = self.list[index]
        //메모이제이션(캐싱)
        if let savedImage = user.thumbnailImage {
            return savedImage
        } else {
            let url:URL! = URL(string: user.picture!)
        
            do {
           // let url:URL! = URL(string: row.picture!)
            let imageData:Data! = try Data(contentsOf: url)
            user.thumbnailImage = UIImage(data:imageData!)
            } catch {
            
            }
        }
        return user.thumbnailImage!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Touch Table Row \(indexPath.row)")
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
