//
//  MPCategory.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPCategory  {
    
    var title : String
    var image : UIImage?
    var rank : Int = 0
    
    init(title : String, image : UIImage?) {
        self.title = title
        self.image = image
    }
}
