//
//  HttpRequest.swift
//  LinkStorage
//
//  Created by Piotr Pawluś on 05/08/15.
//  Copyright (c) 2015 Piotr Pawluś. All rights reserved.
//

import Foundation

class HttpRequest {
    
    func getUrl(base_url: String) -> (String){
        
        var url = "http://to.ly/api.php?longurl=\(base_url)"
      
        var error: NSError?
        var endpoint = NSURL(string: url)
        
        var data = NSData(contentsOfURL: endpoint!, options: nil, error:&error)
        var datastring = NSString(data: data!, encoding:NSASCIIStringEncoding)
        
        var response = datastring as! String
        
        if error != nil {
            println("error: \(error)")
        } else {
            println(response)
        }
        
        return response
    }
}