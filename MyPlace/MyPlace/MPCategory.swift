//
//  MPCategory.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPCategory : NSObject, NSCoding {
    
    var title : String
    var image : UIImage?
    var rank : Int = 0
    
    init(title : String, image : UIImage?, rank : Int = 0) {
        self.title = title
        self.image = image
        self.rank = rank
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let title = aDecoder.decodeObject(forKey: "title") as? String else {
            
            print("Category title is nil")
            return nil
        }
        let image = aDecoder.decodeObject(forKey: "image") as? UIImage
        let rank = aDecoder.decodeObject(forKey: "rank") as? Int ?? 0
    
        self.init(title: title, image: image, rank: rank)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(rank, forKey:"rank")
    }
    
    func incrementRank() {
        
        self.rank += 1
    }
}
