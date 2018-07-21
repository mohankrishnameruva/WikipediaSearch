//
//  page.swift
//  WikipediaSearch
//
//  Created by Mohan on 20/07/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import Foundation
import  Alamofire
import AlamofireImage
class page {
    var pageid : NSNumber?
    var title : String?
    var thumbnail : NSObject?
    var terms : NSObject?
    var description : String?
    var thumbnailImage : UIImage?
    init(obj:NSObject) {
        if let temp = obj.value(forKey: "pageid"){
             self.pageid = temp as! NSNumber
        }
        if let temp = obj.value(forKey: "title"){
            self.title = temp as! String
        }
        if let temp = obj.value(forKey: "thumbnail"){
            self.thumbnail = temp as! NSObject
            if let _  = (temp as! NSObject).value(forKey: "source"){
                GetImageforpage(page: self)
            }
        }
        if let temp = obj.value(forKey: "terms"){
            self.terms = temp as! NSObject
            if let desc = (temp as! NSObject).value(forKey: "description"){
            self.description = (desc as! Array)[0] as String
            }
        }
    }
    
    
    func GetImageforpage(page: page) {
        if let imageUrl = page.thumbnail?.value(forKey: "source"){
            Alamofire.request(imageUrl as! String).responseImage { response in
                
                if let image = response.result.value {
                    page.thumbnailImage = image
                }
            }
        }
    }
}
