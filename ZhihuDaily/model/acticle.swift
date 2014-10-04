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
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    func getFull() {
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/3/news/\(self.id)").responseJSON {
            (req, res, data, err) in
            println(data)
        }
    }
    
    func getTitle() {
        
    }
    
}