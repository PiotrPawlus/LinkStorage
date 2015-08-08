//
//  Fragment2ViewController.swift
//  LinkStorage
//
//  Created by Piotr Pawluś on 05/08/15.
//  Copyright (c) 2015 Piotr Pawluś. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {
    @IBOutlet weak var menuBarButton: UIBarButtonItem!

    var myHttpAddresses: Array<AnyObject> = []
    
    @IBAction func clearHistoryBarButton(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Clear Histowry", message: "Are you sure you want to clear history?", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Clear", style: .Destructive, handler:
            { action in
                println("historia czysta")
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context: NSManagedObjectContext = appDelegate.managedObjectContext!
                let request = NSFetchRequest(entityName: "HttpAddresses")
                
                self.myHttpAddresses = context.executeFetchRequest(request, error: nil)!
                
                for http: AnyObject in self.myHttpAddresses{
                    context.deleteObject(http as! NSManagedObject)
                }
                
                self.myHttpAddresses.removeAll(keepCapacity: false)
                self.tableView.reloadData()
                context.save(nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let request = NSFetchRequest(entityName: "HttpAddresses")
        
        myHttpAddresses = context.executeFetchRequest(request, error: nil)!
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID: String = "cell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellID) as! UITableViewCell
        var fromEnd = myHttpAddresses.count - indexPath.row - 1
        if let ip = indexPath as NSIndexPath? {
            var data: NSManagedObject = myHttpAddresses[fromEnd] as! NSManagedObject
            cell.textLabel?.text = data.valueForKey("shortedAddress") as? String
            cell.detailTextLabel?.text = data.valueForKey("requestAddress") as? String
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myHttpAddresses.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        if editingStyle == .Delete {
            if let tv = tableView as UITableView? {
                context.deleteObject(myHttpAddresses[indexPath.row] as! NSManagedObject)
                myHttpAddresses.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
        
        var error: NSError? = nil
        if !context.save(&error) {
            abort()
        }
    }
    
    func clearHistory() {

    }
}
