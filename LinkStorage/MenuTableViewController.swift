//
//  MenuTableViewController.swift
//  LinkStorage
//
//  Created by Piotr Pawluś on 05/08/15.
//  Copyright (c) 2015 Piotr Pawluś. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var menuPosition = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuPosition = ["Add Link", "History"]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var identifier = menuPosition[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = identifier
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPosition.count
    }
}
