//
//  MPPlaceCollectionViewCell.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPPlaceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeState: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var vicinity: UILabel!
    @IBOutlet weak var types: UILabel!
    
    var place : MPPlace?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.placeName.text = self.place?.name
        self.placeImage.image = self.place?.photo ?? UIImage.init(named: "Place")
        self.vicinity.text = self.place?.vicinity
        self.types.text = self.place?.typesDescription()
        
        self.placeState.isHidden = true
        if let placeState = self.place?.placeState {

            self.placeState.isHidden = false
            self.placeState.text = placeState.rawValue
            self.placeState.textColor = (placeState == .open) ? UIColor.green : UIColor.red
        }
    }
}
