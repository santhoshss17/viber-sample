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
    
    func fetchCategories(completion : ([MPCategory])->Void){

        if let decodedCategories = self.store.object(forKey: "Categories") as? Data, let catConvertedArr = NSKeyedUnarchiver.unarchiveObject(with: decodedCategories) as? [MPCategory]{
            
            completion(catConvertedArr)

        } else {
            
            if let categoriesPath = Bundle.main.path(forResource: "Categories", ofType: "plist") {
                if let catPlistArr = NSArray(contentsOfFile: categoriesPath) as? Array<[String:String]> {
                    var catConvertedArr : [MPCategory] = [MPCategory]()
                    for category in catPlistArr {
                        if let title = category["title"], let image = category["image"] {
                            catConvertedArr.append(MPCategory(title:title, image: UIImage(named : image)))
                        }
                    }
                    
                    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: catConvertedArr)
                    self.store.set(encodedData, forKey: "Categories")
                    
                    completion(catConvertedArr)
                }
            }
        }
    }
    
    func updateStore(category : MPCategory){
        
        
    }
}

