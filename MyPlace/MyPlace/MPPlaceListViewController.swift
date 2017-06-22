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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
//        let visibleCells = self.collectionView.visibleCells
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height : CGFloat = scrollView.contentSize.height-scrollView.frame.size.height
        if (scrollView.contentOffset.y == CGFloat(roundf(Float(height)))) {
            
            self.presenter.didReachedEndOfContent()
        }
    }
    
//    - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
//        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
//        NSUInteger lastIndex = [indexPath indexAtPosition:[indexPath length] - 1];
//        }
//    }
}
