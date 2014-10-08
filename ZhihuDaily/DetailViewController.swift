//
//  DetailViewController.swift
//  ZhihuDaily
//
//  Created by fantasy on 8/10/14.
//  Copyright (c) 2014 FantasyShao. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var _title: UILabel!
    
    var storyId: Int!
    var story: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/3/news/\(self.storyId)").responseJSON {
            (req, res, data, err) in
            var arr = data as NSDictionary
            self._title.text = arr.objectForKey("title")! as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
