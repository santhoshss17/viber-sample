//
//  MPCategoryListInteractor.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPCategoryListInteractor : CategoryListUseCase{
    
    weak var output: CategoryListInteractorOutput!
    
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

}
