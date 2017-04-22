//
//  RecipeCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by mac on 2017. 4. 19..
//  Copyright © 2017년 StudioKJ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class RecipeCollectionViewController: UICollectionViewController {

    var recipeImages = ["angry_birds_cake", "creme_brelee", "egg_benedict",
                        "full_breakfast", "green_tea", "ham_and_cheese_panini", "ham_and_egg_sandwich",
                        "hamburger", "instant_noodle_with_egg", "japanese_noodle_with_pork",
                        "mushroom_risotto", "noodle_with_bbq_pork", "starbucks_coffee",
                        "thai_shrimp_cake", "vegetable_curry", "white_chocolate_donut"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
        //        cell.selectedBackgroundView =
        //            UIImageView(image: UIImage(named: "photo-frame-selected"))
        
        return cell
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
