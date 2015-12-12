//
//  WordsInterfaceController.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/9/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import WatchKit
import Foundation


class WordsInterfaceController: WKInterfaceController {
    
    @IBOutlet var word: WKInterfaceLabel!
    @IBOutlet var wpm: WKInterfaceLabel!
    let words = Words()
    let delegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
    var interval = 100.00
    
    @IBAction func doStart() {
        delegate.timer = NSTimer.scheduledTimerWithTimeInterval(60.0 / interval, target: self, selector: "showNextWord", userInfo: nil, repeats: true)
    }
    
    func showNextWord() {
        dispatch_async(dispatch_get_main_queue(), {
            () -> Void in
            self.word.setText(self.words.next())
        })
    }
    
    @IBAction func doStop() {
        if let _ = delegate.timer {
            delegate.timer.invalidate()
        }
    }
    
    func newInterval(newinterval: Double) {
        doStop()
        interval = newinterval
        wpm.setText("\(newinterval) WPM")
        doStart()
    }
    
    @IBAction func doSlide(value: Float) {
        newInterval(Double(value))
    }
    
}
