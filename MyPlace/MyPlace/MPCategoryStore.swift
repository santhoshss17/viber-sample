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
    
    func fetchCategories(completion : ([MPCategory])->Void){

        if let categoriesPath = Bundle.main.path(forResource: "Categories", ofType: "plist") {
            if let catPlistArr = NSArray(contentsOfFile: categoriesPath) as? Array<[String:String]> {
                var catConvertedArr : [MPCategory] = [MPCategory]()
                for category in catPlistArr {
                    if let title = category["title"], let image = category["image"] {
                        catConvertedArr.append(MPCategory(title:title, image: UIImage(named : image)))
                    }
                }
                
                completion(catConvertedArr)
            }
        }
    }
    
    func updateStore(category : MPCategory){
        
        
    }
}

