//
//  MPAppDependency.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPAppDependency {
    
    var rootRouter : MPRootRouter?
    
    init() {
        
        self.rootRouter = MPCategoryListRouter()
    }
    
    func loadRootRouter(window : UIWindow) {
        
        self.rootRouter?.loadRootView(window: window)
    }
    
}
