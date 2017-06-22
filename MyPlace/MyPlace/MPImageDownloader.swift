//
//  MPImageDownloader.swift
//  MyPlace
//
//  Created by Santosh Shanbhag on 22/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

protocol MPImageDownloaderDatasource {
    
    func imageUrl() -> URL?
    func setImage(image : UIImage)
}

class MPImageDownloader {
    
    private var sessionTask : URLSessionDataTask?
    var dataSource : MPImageDownloaderDatasource
    var context : AnyObject?
    
    init(dataSource : MPImageDownloaderDatasource, context : AnyObject?) {
        
        self.dataSource = dataSource
        self.context = context
    }
    
    func startDownload(completion : @escaping () -> Void) {
        
        if let url = self.dataSource.imageUrl() {
         
            let request = URLRequest(url: url)
            self.sessionTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                OperationQueue.main.addOperation({
                    
                    if let imgData = data, let image = UIImage(data: imgData) {
                        
                        self.dataSource.setImage(image: image)
                    }
                    
                    completion()
                })
            }
        } else {
            
            completion()
        }
    }
    
    func cancelDownload() {
        
        self.sessionTask?.cancel()
    }
}
