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

    @IBOutlet weak var tableView: UITableView!
    
    var latestItems = NSMutableArray()
    let url = "http://news-at.zhihu.com/api/3/news/latest"
    let identifier = "cell"
    
    // UI related params
    let appTitle: String = "知乎 · 日报"
    let navBgColor: UIColor = UIColor(red: 0.3, green: 0.4, blue: 0.9, alpha: 0)
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        
        self.configUI()
        self.loadData()
    }

    override func viewWillAppear(animated: Bool) {
        if tableView.indexPathForSelectedRow() != nil {
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: animated)
        }
        
        super.viewDidAppear(animated)
    }
    
    // Customize UI
    func configUI() {
        
        // View
        self.title = self.appTitle
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Refresh
        self.refreshControl.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        self.refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.tableView.insertSubview(refreshControl, atIndex: 0)
        
    }
    
    // Load data
    func loadData() {
        Alamofire.request(.GET, self.url).responseJSON {
            (req, res, data, err) in
            // Data load fail
            if err != nil {
                // Reference: http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
                var alert = UIAlertController(title: "Zhihu Daily", message: "Data load failed", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // Empty all objects when fresh
                self.latestItems.removeAllObjects()
                
                var arr = data?["stories"] as NSArray
                
                for data : AnyObject in arr {
                    self.latestItems.addObject(data)
                }
                
                self.tableView!.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.latestItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(self.identifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = self.latestItems[indexPath.row]["title"] as? String
        cell.textLabel?.textColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
        
        cell.contentView.layoutIfNeeded()
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel!.numberOfLines = 0
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
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

}

