//
//  CatalogMenu.swift
//  GLSearch
//
//  Created by Peter Yorke on 12/7/15.
//  Copyright © 2015 Storke Brothers LLC. All rights reserved.
//

import UIKit

/*
 *
 * class CatalogMenu
 *
 * handle the UITableViewController that lists the content, folders and books, returned by the API.
 * this class is also reused when a folder is clicked on, since the contents of a folder are pretty
 * much the same as the contents of the catalog
 *
 */
class CatalogMenu: UITableViewController {
    
    var language = 0
    var forced = false
    var catalog = Catalog()

    /*
     * viewDidLoad()
     * if this is an original Catalog from LanguageMenu, as the Model to fetch the contents of the
     * catalog. When the user clicks on a folder "forced" is set to true, so the call to Model is
     * not necessary, because the invoking CatalogMenu instance has already filled in catalog.folders
     * and catalog.books
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        if !forced { // forced is set true by an earlier instance of CatalogMenu
            Model().getCatalogForLanguage(language) {
                cat in
                self.catalog = cat
                dispatch_async(dispatch_get_main_queue(), {
                    self.title = cat.name
                    self.tableView.reloadData()
                })
            }
        } else {
            self.title = catalog.name
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
     * return the count of folders plus the count of books
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalog.folders.count + catalog.books.count
    }

    /*
     * cellForRowAtIndexPath()
     * if the desired row is within the range of the count of folders, use a FolderContent prototype,
     * get the name from the appropriate folder in the folders array, and use a different color.
     * if the desired row is greater than the range of the count of folders, use a BookContent prototype
     * and get the name from the appropriate book in the books array.
     * different prototypes are used so that separate segues can be attached to each
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var row = indexPath.row
        if row >= catalog.folders.count { // Books
            let cell = tableView.dequeueReusableCellWithIdentifier("BookContent", forIndexPath: indexPath)
            row -= catalog.folders.count
            cell.textLabel!.text = catalog.books[row].name
            cell.textLabel!.textColor = UIColor.blackColor()
            return cell
        } else { // Folders
            let cell = tableView.dequeueReusableCellWithIdentifier("FolderContent", forIndexPath: indexPath)
            cell.textLabel!.text = catalog.folders[row].name
            cell.textLabel!.textColor = UIColor.brownColor()
            return cell
        }
    }
    
    // MARK: - Navigation

    /*
     * prepareForSegue()
     * a FolderSegue will push a new instance of CatalogMenu, so its 'forced' needs to be set to true
     * and its 'catalog' needs to be filled with the name, folders and books of the folder that
     * was selected.
     * a BookSegue goes to a null page for now, but in the future the name of the book would be sent
     * to a Contents instance, which would decode and display the book
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var row = self.tableView.indexPathForSelectedRow!.row
        switch segue.identifier! {
        case "FolderSegue":
            if let controller = segue.destinationViewController as? CatalogMenu {
                let folder = catalog.folders[row]
                controller.forced = true
                controller.catalog.name = folder.name
                controller.catalog.folders = folder.folders
                controller.catalog.books = folder.books
            }
        case "BookSegue":
            row -= catalog.folders.count
        default: break;
        }
    }

}
