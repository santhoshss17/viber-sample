//
//  MPCategoryListviewController.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPCategoryListviewController  :  UIViewController {
    
    var presenter: CategoryListPresenter!
    var categories : [MPCategory]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewReadyToConfigure()
    }
}

extension MPCategoryListviewController : CategoryListView {
    
    func setTitle(title : String) {
        
        self.title = title
    }
    
    func reloadCategories(sort : MPSortCategory = .rank) {

        self.categories = self.presenter.categories
        
        switch sort {
        case .rank:
            self.categories?.sort(by: {$0.rank > $1.rank})
            
        default:
            break
        }

        self.tableView.reloadData()
    }
}

extension MPCategoryListviewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.presenter.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath)
        cell.textLabel?.text = self.categories?[indexPath.row].title
        cell.imageView?.image = self.categories?[indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedCategory = self.categories?[indexPath.row] {
            self.presenter.userDidSelect(category : selectedCategory)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

