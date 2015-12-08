//
//  Model.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import Foundation
import UIKit

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
        getJSON("http://tech.lds.org/glweb?action=languages.query&format=json") {
            json in
            var languages = [Language]()
            let dict = json as? NSDictionary
            if let responses = dict?["languages"] as? NSArray {
                for response in responses {
                    languages.append(Language(response as! NSDictionary))
                }
            }
            handler(languages)
        }
    }
    
    /*
     * getiPhonePlatformId()
     * get the plaform id of the first platform (from the API) that has a name of "iPhone"
     */
    func getiPhonePlatformId(handler: (Int)->Void) {
        getJSON("http://tech.lds.org/glweb?action=platforms.query&format=json") {
            json in
            let dict = json as? NSDictionary
            if let responses = dict?["platforms"] as? NSArray {
                for response in responses {
                    let platform = Platform(response as! NSDictionary)
                    if platform.name == "iPhone" {
                        handler(platform.id)
                    }
                }
            }
        }
    }

    /*
     * getCatalogForLanguage()
     * get the catalog entry from the API
     */
    func getCatalogForLanguage(lang: Int, handler: (Catalog)->Void) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        getJSON("http://tech.lds.org/glweb?action=catalog.query&languageid=\(lang)&platformid=\(delegate.platform)&format=json") {
            json in
            let dict = json as? NSDictionary
            if let responses = dict?["catalog"] as? NSDictionary {
                let catalog = Catalog(responses)
                handler(catalog)
            }
        }
    }
    
    /*
     * getJSON()
     * function to do all the network communications heavy lifting
     */
    private func getJSON(urlString: String, handler: (AnyObject)->Void) {
        let url = NSURL(string: urlString)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            do {
                let json: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                handler(json)
            } catch {
                fatalError()
            }
        }
        task.resume()
    }
    
}
