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
    var type : String?
    
    init(title : String, image : UIImage?, rank : Int = 0, type : String?) {
        self.title = title
        self.image = image
        self.rank = rank
        self.type = type
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let title = aDecoder.decodeObject(forKey: "title") as? String else {
            
            print("Category title is nil")
            return nil
        }
        let image = aDecoder.decodeObject(forKey: "image") as? UIImage
        let rank = aDecoder.decodeObject(forKey: "rank") as? Int ?? 0
        let type = aDecoder.decodeObject(forKey: "type") as? String
    
        self.init(title: title, image: image, rank: rank, type: type)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(rank, forKey:"rank")
        aCoder.encode(type, forKey:"type")
    }
    
    func incrementRank() {
        
        self.rank += 1
    }
}

func ==(lhs: MPCategory, rhs: MPCategory) -> Bool {
    
    return lhs.title == rhs.title
}
