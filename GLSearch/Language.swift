//
//  Language.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation

class Language {
    
    var id = 0
    var name = "" // English name for this language
    
    /*
     * init()
     * initialize using an NSDictionary from the API
     */
    init(_ dict: NSDictionary) {
        if let value = dict["id"] {
            id = value as! Int
        }
        if let value = dict["eng_name"] {
            name = value as! String
        }
    }
    
}