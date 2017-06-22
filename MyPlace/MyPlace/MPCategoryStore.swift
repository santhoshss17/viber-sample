//
//  MPCategoryStore.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPCategoryStore {
    
    static let shared : MPCategoryStore = MPCategoryStore()
    private var store : UserDefaults {
        
        return UserDefaults.standard
    }
    
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    func fetchCategories(completion : ([MPCategory])->Void){

        if let decodedCategories = self.store.data(forKey: "Categories"), let catConvertedArr = NSKeyedUnarchiver.unarchiveObject(with: decodedCategories) as? [MPCategory]{
            
            completion(catConvertedArr)

        } else {
            
            if let categoriesPath = Bundle.main.path(forResource: "Categories", ofType: "plist") {
                if let catPlistArr = NSArray(contentsOfFile: categoriesPath) as? Array<[String:String]> {
                    var catConvertedArr : [MPCategory] = [MPCategory]()
                    for category in catPlistArr {
                        if let title = category["title"], let image = category["image"] {
                            catConvertedArr.append(MPCategory(title:title, image: UIImage(named : image), type : category["type"]))
                        }
                    }
                    
                    self.updateStore(categories: catConvertedArr)
                    completion(catConvertedArr)
                }
            }
        }
    }
    
    func updateStore(category : MPCategory){
        
        self.fetchCategories { (categories) in
            
            _ = categories.map({ (storeCategory) -> MPCategory in
                
                if storeCategory == category {
                    storeCategory.rank = category.rank
                }
                
                return storeCategory
            })
            
            self.updateStore(categories: categories)
        }
    }
    
    private func updateStore(categories : [MPCategory]) {
    
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: categories)
        self.store.set(encodedData, forKey: "Categories")
        self.store.synchronize()
    }
    
    @objc func didEnterBackground() {
        
        self.store.synchronize()
    }
}

