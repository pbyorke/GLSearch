//
//  Model.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation

/*
 *
 * The Model class will handle all of the network requests, returning the data in the desired format
 *
 */
class Model {
 
    /*
     * getLanguages()
     * call the API that returns all the available languages
     */
    func getLanguages(handler: ([Language])->Void) {
        let url = NSURL(string: "http://tech.lds.org/glweb?action=languages.query&format=json") // hard coding because it doesn't change
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            var languages = [Language]()
            do {
                let json: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                let dict = json as? NSDictionary
                if let responses = dict?.objectForKey("languages") as? NSArray {
                    for response in responses {
                        languages.append(Language(response as! NSDictionary))
                    }
                }
            } catch {
                fatalError()
            }
            handler(languages)
        }
        task.resume()
    }
    
}
