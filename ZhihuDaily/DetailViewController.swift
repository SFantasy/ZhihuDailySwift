//
//  DetailViewController.swift
//  ZhihuDaily
//
//  Created by fantasy on 8/10/14.
//  Copyright (c) 2014 FantasyShao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var storyId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(self.storyId)
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
