//
//  WordsInterfaceController.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/9/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import WatchKit
import Foundation

/*
 * class WordsInterfaceController
 *
 * Control the view that displays words at a measured pace. The word
 * is displayed in the middle of the screen in a large font. A slider
 * paired with a display of the number of words per minute gives the
 * user control over the pace. Start and Stop buttons allow the display
 * to be frozen and the timer stopped
 *
 */
class WordsInterfaceController: WKInterfaceController {
    
    @IBOutlet var word: WKInterfaceLabel!
    @IBOutlet var wpm: WKInterfaceLabel!
    let words = Words()
    let delegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
    var interval = 100.00
    var counter = 0.0
    
    /*
     * doStart()
     * action performed when the Start button is pressed
     */
    @IBAction func doStart() {
        if let _ = delegate.timer { // make sure we have a timer
            while delegate.timer.valid { // keep trying to stop it until it's not valid (stopped)
                doStop()
            }
        }
        delegate.timer = NSTimer(timeInterval: 0.1, // fire off a timer every 0.10 seconds
            target: self,
            selector: "timerFired",
            userInfo: nil,
            repeats: true)
        NSRunLoop.currentRunLoop().addTimer(delegate.timer, forMode: NSRunLoopCommonModes) // put into loop that UI isn't using
    }
    
    /*
     * timerFired()
     * the timer has fired, now we need to figure out if this is the 'right' firing for this wpm
     *
     * if we assume a max of 600 wpm, that works out to one every 0.10 second. To find out how
     * many timer firings we need for a given wpm we divide that number into 600
     */
    func timerFired() {
        counter++ // another tick of the timer
        let threshold = 600.0 / interval // number of ticks needed for this wpm
        if counter >= threshold { // okay, time to show a word
            counter = 0.0 // reset
            showNextWord()
        }
    }

    /*
     * showNextWord()
     * get the next word to be shown, then dispatch the main
     * queue and put the word into the UI
     */
    func showNextWord() {
        dispatch_async(dispatch_get_main_queue(), {
            () -> Void in
            self.word.setText(self.words.next())
        })
    }
    
    /*
     * doStop()
     * action perfored when the Stop button is pressed
     *
     * basically, stop the timer
     */
    @IBAction func doStop() {
        if let _ = delegate.timer {
            delegate.timer.invalidate()
        }
    }

    /*
     * newInterval()
     * receive notification from the slider that a new value has been
     * chosen
     *
     * stuff the new interval in the common var where timerFired() will find
     * it, and display the new vlaue on the screen
     */
    @IBAction func newInterval(value: Float) {
        interval = Double(value)
        wpm.setText("\(Int(value)) WPM")
    }
    
}
