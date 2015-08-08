//
//  Fragment1ViewController.swift
//  LinkStorage
//
//  Created by Piotr Pawluś on 05/08/15.
//  Copyright (c) 2015 Piotr Pawluś. All rights reserved.
//

import UIKit
import CoreData

class AddLinkViewController: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    var httpRequest = HttpRequest()
    
    @IBOutlet var httpTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textAddedLabel: UILabel!
    
    
    @IBAction func inputChanged(textField: UITextField) {
        if verifyUrl(httpTextField.text) {
            addButton.enabled = true
        } else if !verifyUrl(httpTextField.text) {
            addButton.enabled = false
        }
    }
    
    @IBAction func addLink(sender: UIButton) {
        if !httpTextField.text.isEmpty && verifyUrl(httpTextField.text){
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.managedObjectContext!
            
            let entity = NSEntityDescription.entityForName("HttpAddresses", inManagedObjectContext: context)
            
            var newHttpAddress = HttpAddresses(entity: entity!, insertIntoManagedObjectContext: context)
            
            if (httpTextField.text.hasPrefix("http://") || httpTextField.text.hasPrefix("https://")) {
                newHttpAddress.shortedAddress = httpTextField.text.lowercaseString
                newHttpAddress.requestAddress = httpRequest.getUrl(httpTextField.text)
            } else {
                newHttpAddress.shortedAddress = "http://\(httpTextField.text)".lowercaseString
                newHttpAddress.requestAddress = httpRequest.getUrl("http://\(httpTextField.text)")
            }


            context.save(nil)
        }
        
        self.textAddedLabel.hidden = false
        self.textAddedLabel!.text = "\(self.httpTextField.text.lowercaseString) added"
        delay(2.5) {
            self.textAddedLabel.hidden = true
        }
        self.httpTextField.resignFirstResponder()
        httpTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }


        textAddedLabel.hidden = true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    

    
    func verifyUrl (urlString: String?) -> Bool {
        var urlRegEx = "((http://)|(https://))?((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        var urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluateWithObject(urlString!)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}
