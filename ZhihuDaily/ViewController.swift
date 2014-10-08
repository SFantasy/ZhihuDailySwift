//
//  ViewController.swift
//  ZhihuDaily
//
//  Created by fantasy on 4/10/14.
//  Copyright (c) 2014 FantasyShao. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let url = "http://news-at.zhihu.com/api/3/news/latest"
    let identifier = "cell"
    
    var latestItems = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "知乎 · 日报"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        
        self.loadData()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.latestItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(self.identifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = self.latestItems[indexPath.row]["title"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: self.view)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            var index = self.tableView.indexPathForSelectedRow()?.row
            var data = self.latestItems[index!] as NSDictionary
            var destination = segue.destinationViewController as DetailViewController
            destination.storyId = data["id"] as Int
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        Alamofire.request(.GET, self.url).responseJSON {
            (req, res, data, err) in
            // 数据加载失败
            if err != nil {
                // Reference: http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
                var alert = UIAlertController(title: "Zhihu Daily", message: "Data load failed", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                var arr = data?["stories"] as NSArray
                
                for data : AnyObject in arr {
                    self.latestItems.addObject(data)
                }
                
                self.tableView!.reloadData()
            }
        }
    }
    
}

