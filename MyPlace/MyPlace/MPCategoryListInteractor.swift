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
        
        MPCategoryStore.shared.fetchCategories { (categories) in
            completion(categories)
        }
    }
    
}
