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
    
    func loadOnScreenImages() {
        
        let visibleCells = self.collectionView.indexPathsForVisibleItems
        
        for indexPath in visibleCells {
            
            let place = self.presenter.places[indexPath.row]
            if place.photo == nil {
                self.presenter.needsImageForCell(context: indexPath, place: place)
            }
        }
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
    
    func imageDownloaded(context : IndexPath, place : MPPlace) {
        
        if let cell = self.collectionView.cellForItem(at: context) as? MPPlaceCollectionViewCell {
            cell.placeImage.image = place.photo
        }
    }

}

extension MPPlaceListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.presenter.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MPPlaceCollectionViewCell", for: indexPath) as! MPPlaceCollectionViewCell
        
        let place = self.presenter.places[indexPath.row]
        cell.place = place
        
        if collectionView.isDragging == false && collectionView.isDecelerating == false {
            
            self.presenter.needsImageForCell(context : indexPath, place : place)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let place = self.presenter.places[indexPath.row]
        self.presenter.didSelectPlace(place: place)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        self.loadOnScreenImages()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            
            self.loadOnScreenImages()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height : CGFloat = scrollView.contentSize.height-scrollView.frame.size.height
        if (scrollView.contentOffset.y == CGFloat(roundf(Float(height)))) {
            
            self.presenter.didReachedEndOfContent()
        }
    }
}
