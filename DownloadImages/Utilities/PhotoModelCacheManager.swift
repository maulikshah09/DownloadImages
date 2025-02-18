//
//  PhotoModelCacheManager.swift
//  DownloadImages
//
//  Created by Maulik Shah on 2/18/25.
//

import SwiftUI
import Foundation

class PhotoModelCacheManager{
    static let instance  = PhotoModelCacheManager()
    private init(){}
    
    var photoCache : NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(key: String,value : UIImage){
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage?{
        return photoCache.object(forKey: key as NSString)
    }
    
    
}
