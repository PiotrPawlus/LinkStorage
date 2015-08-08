//
//  HttpAddresses.swift
//  LinkStorage
//
//  Created by Piotr Pawluś on 05/08/15.
//  Copyright (c) 2015 Piotr Pawluś. All rights reserved.
//

import Foundation
import CoreData

@objc(HttpAddresses)
class HttpAddresses: NSManagedObject {
    
    @NSManaged var requestAddress: String
    @NSManaged var shortedAddress: String
    
    func getHttp() -> (requestAddress: String, shortedAddress: String) {
        return (self.requestAddress, self.shortedAddress)
    }
    
    func toString() -> String {
        return "Address: \(requestAddress), Short Address: \(shortedAddress)"
    }
}