//
//  Catalog.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation

class Catalog {
    
    var name = ""
    var folders = [Folder]()
    var books = [Book]()
    
    init(){}
    
    init(_ dict: NSDictionary) {
        if let value = dict["name"] {
            name = value as! String
        }
    }
    
}