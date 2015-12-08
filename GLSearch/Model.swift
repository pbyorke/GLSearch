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
        let url = NSURL(string: "http://tech.lds.org/glweb?action=languages.query&format=json") // hard coding because it doesn't change
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            var languages = [Language]()
            do {
                let json: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                let dict = json as? NSDictionary
                if let responses = dict?["languages"] as? NSArray {
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

    /*
     * getiPhonePlatformId()
     * get the plaform id of the first platform (from the API) that has a name of "iPhone"
     */
    func getiPhonePlatformId(handler: (Int)->Void) {
        let url = NSURL(string: "http://tech.lds.org/glweb?action=platforms.query&format=json") // hard coding because it doesn't change
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            do {
                let json: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                let dict = json as? NSDictionary
                if let responses = dict?["platforms"] as? NSArray {
                    for response in responses {
                        let platform = Platform(response as! NSDictionary)
                        if platform.name == "iPhone" {
                            handler(platform.id)
                        }
                    }
                }
            } catch {
                fatalError()
            }
        }
        task.resume()
    }

    /*
     * getCatalogForLanguage()
     * get the catalog entry from the API
     */
    func getCatalogForLanguage(lang: Int, handler:(Catalog)->Void) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let url = NSURL(string: "http://tech.lds.org/glweb?action=catalog.query&languageid=\(lang)&platformid=\(delegate.platform)&format=json") // hard coding because it doesn't change
        
//        print("\((url?.absoluteString)!)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            do {
                let json: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                let dict = json as? NSDictionary
                if let responses = dict?["catalog"] as? NSDictionary {
                    let catalog = Catalog(responses)
                    handler(catalog)
                }
            } catch {
                fatalError()
            }
        }
        task.resume()
    }
    
}
