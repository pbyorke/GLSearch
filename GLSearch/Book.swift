//
//  Book.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation

class Book {
    
    var name = ""
    var description = ""
    var url = ""
    
    init(_ dict: NSDictionary) {
        if let value = dict["name"] {
            name = value as! String
        }
        if let value = dict["description"] {
            description = value as! String
        }
        if let value = dict["url"] {
            url = value as! String
        }
    }
}