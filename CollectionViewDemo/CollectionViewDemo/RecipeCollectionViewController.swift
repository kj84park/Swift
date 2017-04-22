//
//  RecipeCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by mac on 2017. 4. 19..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit
import Social

private let reuseIdentifier = "Cell"

class RecipeCollectionViewController: UICollectionViewController {

    var recipeImages = ["angry_birds_cake", "creme_brelee", "egg_benedict",
                        "full_breakfast", "green_tea", "ham_and_cheese_panini", "ham_and_egg_sandwich",
                        "hamburger", "instant_noodle_with_egg", "japanese_noodle_with_pork",
                        "mushroom_risotto", "noodle_with_bbq_pork", "starbucks_coffee",
                        "thai_shrimp_cake", "vegetable_curry", "white_chocolate_donut"]
    
    var selectedRecipes:[String] = []
    
    @IBAction func shareButtonTaped(_ sender: Any) {
        
        if shareEnabled {
            //posting selected pic on facebook
            if selectedRecipes.count > 0 {
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                    let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    facebookComposer?.setInitialText("내 레시피 체크하기!")
                    for recipePhoto in selectedRecipes {
                        facebookComposer?.add(UIImage(named: recipePhoto))
                    }
                    present(facebookComposer!, animated: true, completion: nil)
                }
            }
            
            //모든 선택된 아이템들의 선택을 해지한다.
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                for indexPath in indexPaths {
                    collectionView?.deselectItem(at: indexPath, animated: false)
                }
            }
            
            //selectedRecipes배열에서 모든 아이템들을 삭제한다.
            selectedRecipes.removeAll(keepingCapacity: true)
            //sharing모드를 NO로 변경한다.
            shareEnabled = false
            collectionView?.allowsMultipleSelection = false
            shareButton.title = "Share"
            shareButton.style = UIBarButtonItemStyle.plain
        } else {
            shareEnabled = true
            collectionView?.allowsMultipleSelection = true;
            shareButton.title = "upload"
            shareButton.style = UIBarButtonItemStyle.done
            
        }
        
    }
    
    @IBOutlet var shareButton: UIBarButtonItem!
    
    //selection 모드에서 공유를 위한 변수
    var shareEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //공유모드에서 트리거되면 공유모드를 다시 리셋해준다.
        if identifier == "showRecipePhoto" {
            if shareEnabled {
                return false
            }
        }
        
        return true
    }
    
    
    @IBAction func unwindReturnSegue(segue:UIStoryboardSegue){
        print("되돌아옴")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //공유 모드가 활성화되어 있으면 처리하고 그렇지 않으면 빠져나가기
        guard shareEnabled else {
            return
        }
        
        //indexPath를 사용해서 선택된 아이템들을 검사하기
        let selectedRecipe = recipeImages[indexPath.row]
        //배열에 선택된 아이템들을 추가하기
        selectedRecipes.append(selectedRecipe)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recipeImages.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! RecipeCollectionViewCell
        
        // Configure the cell
        cell.recipeImageView.image = UIImage(named: recipeImages[indexPath.row])
        
        //백그라운드 이미지를 셋팅한다.
        cell.backgroundView = UIImageView(image: UIImage(named: "photo-frame"))
        
        //선택되었을 때의 백그라운드 이미지를 셋팅한다.
        cell.selectedBackgroundView = UIImageView(image: UIImage(named: "photo-frame-selected"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showRecipePhoto" {
            
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationViewController = segue.destination as! UINavigationController
                let photoViewController = destinationViewController.viewControllers[0] as! PhotoDetailViewCellViewController
                photoViewController.imageName = recipeImages[indexPaths[0].row]
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
