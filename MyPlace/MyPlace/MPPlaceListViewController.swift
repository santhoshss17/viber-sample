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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewReadyToConfigure()
    }
}

extension MPPlaceListViewController : PlaceListView {
    
    func setTitle(title : String) {
        
        self.title = title
    }
    
    func reloadPlaces() {
        
        self.collectionView.reloadData()
    }
    
    func displayAlert(message : String, primaryButtonTitle : String) {
        
        let alert = UIAlertController(title: self.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: primaryButtonTitle, style: .default, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: { 
            
        })
    }
}

extension MPPlaceListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.presenter.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MPPlaceCollectionViewCell", for: indexPath) as! MPPlaceCollectionViewCell
        
        cell.place = self.presenter.places[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let place = self.presenter.places[indexPath.row]
        self.presenter.didSelectPlace(place: place)
    }
}
