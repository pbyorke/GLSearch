//
//  Words.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/9/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation

/*
 *
 * class Words
 *
 * Temporary repository of words that can be displayed
 *
 */
class Words {
    let words = [
            "When","in","the","course","of","human","events","it","becomes","necessary",
            "for","one","people","to","dissolve","the","political","bands","which","have",
            "connected","them","with","another","and","to","assume","among","the","powers",
            "of","the","earth,","the","separate","and","equal","station","to","which","the",
            "Laws","of","Nature","and","of","Nature's","God","entitle","them,","a","decent",
            "respect","to","the","opinions","of","mankind","requires","that","they","should",
            "declare","the","causes","which","impel","them","to","the","separation."
        ]
    var index = -1
    
    /*
     * next()
     * return the next word in the array, or if at the end go back to the beginning
     */
    func next() -> String {
        if ++index >= words.count {
            index = 0
        }
        return words[index]
    }
    
}