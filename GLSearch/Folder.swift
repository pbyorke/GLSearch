//
//  Folder.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation

class Folder {
    
    var name = ""
    var folders = [Folder]()
    var books = [Book]()
    
    init(_ dict: NSDictionary) {
        if let value = dict["name"] {
            name = value as! String
        }
        if let value = dict["books"] {
            let array = value as? NSArray
            for entry in array! {
                books.append(Book(entry as! NSDictionary))
            }
        }
        if let value = dict["folders"] {
            let array = value as? NSArray
            for entry in array! {
                folders.append(Folder(entry as! NSDictionary))
            }
        }
    }
    
}
