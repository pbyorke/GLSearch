//
//  ExtensionDelegate.swift
//  GLSearchFast Extension
//
//  Created by Peter Yorke on 12/8/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    var timer: NSTimer!

    func applicationDidFinishLaunching() {}

    func applicationDidBecomeActive() {}

    func applicationWillResignActive() {
        timer.invalidate()
    }

}
