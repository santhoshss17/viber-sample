//
//  MPConstants.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation

enum MPSortCategory {
    case none
    case rank
}

let kGAPIKey = "AIzaSyBRXKxz7WL2-5iXecdh8-O9g3qO9JR1ohM"
let kGMAPKey = "AIzaSyCVjeu5iooX5yUF4_T43mIiYPAI66gm8J0"

let kGAPIPlace = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
let kGAPIPhoto = "https://maps.googleapis.com/maps/api/place/photo?" //maxwidth=400&photoreference=<Ref>&key=YOUR_API_KEY"

let kMPLocationUpdateNotificationKey = "DidReceivedLocationUpdate"
let kGMAPRadius = "5000" //5KM Radius
