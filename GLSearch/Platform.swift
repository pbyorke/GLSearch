//
//  Platform.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation

class Platform {
    
    var id = 0 // id to use in other API calls
    var name = "" // English name for this language
    
    /*
    * init()
    * initialize using an NSDictionary from the API
    */
    init(_ dict: NSDictionary) {
        if let value = dict["id"] {
            id = value as! Int
        }
        if let value = dict["name"] {
            name = value as! String
        }
    }
    
}