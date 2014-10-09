//
//  DetailViewController.swift
//  ZhihuDaily
//
//  Created by fantasy on 8/10/14.
//  Copyright (c) 2014 FantasyShao. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var _title: UILabel!
    @IBOutlet weak var _content: UIWebView!
    
    var storyId: Int!
    var story: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._content.scrollView.delegate = self
        self.loadData()
    }
    
    func loadData() {
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/3/news/\(self.storyId)").responseJSON {
            (req, res, data, err) in
            
            if err != nil {
                var alert = UIAlertController(title: "Zhihu Daily", message: "Data load failed", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                var arr = data as NSDictionary
                var body = arr.objectForKey("body")! as String
                var cssArr = arr.objectForKey("css") as NSArray
                var css = cssArr[0] as String
                body = "<link href='\(css)' type='text/css'/>\(body)"
                
                self._title.text = arr.objectForKey("title")! as? String
                self._content.loadHTMLString(body, baseURL: nil)
            }
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
