//
//  acticle.swift
//  ZhihuDaily
//
//  Created by fantasy on 4/10/14.
//  Copyright (c) 2014 FantasyShao. All rights reserved.
//

import Foundation
import Alamofire

class Article {
    
    let id: Int
    var title: String?
    
    init(id: Int) {
        self.id = id
    }
    
    func getFull(callback: Void) {
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/3/news/\(self.id)").responseJSON {
            (req, res, data, err) in
            var arr = data as NSDictionary
            self.title = arr.objectForKey("title")! as? String
            println(self.title)
            callback
        }
    }
    
    func getTitle() {
        
    }
    
}