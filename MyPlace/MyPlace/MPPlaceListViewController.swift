//
//  MPPlaceListViewController.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPPlaceListViewController : UIViewController  {
    
    var presenter: PlaceListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewReadyToConfigure()
    }
}

extension MPPlaceListViewController : PlaceListView {
    
    func setTitle(title : String) {
        
        self.title = title
    }

}
