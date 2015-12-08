//
//  LanguageMenu.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import UIKit

class LanguageMenu: UITableViewController {
    
    var languages = [Language]() // array of languages available through the API

    /*
     * viewDidLoad()
     * ask the Model to fetch all the languages from the API
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        Model().getLanguages() {
            list in
            self.languages = list
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
            
        }
    }

    /*
     * didReceiveMemoryWarning()
     * just letting the superclass handle memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    /*
     * numberOfSectionsInTableView()
     * always return 1 section
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    /*
     * numberOfRowsInSection()
     * return the count of languages as the number of rows
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    /*
     * cellForRowAtIndexPath()
     * return the name of a language based on the row number
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Language", forIndexPath: indexPath)
        cell.textLabel!.text = languages[indexPath.row].engName
        return cell
    }

    // MARK: - Navigation

    /*
     * prepareForSegue()
     * prepare the upcoming table view controller based on the selected row
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }

}
