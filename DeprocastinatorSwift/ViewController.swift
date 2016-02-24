//
//  ViewController.swift
//  DeprocastinatorSwift
//
//  Created by south boske on 2/23/16.
//  Copyright © 2016 com.boske.south. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var todoListArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoListArray = [""]
        self.editing = false
    }
    
    @IBAction func onAddButtonPressed(sender: UIBarButtonItem) {
        self.todoListArray.addObject(self.textField.text!)
        self.tableView.reloadData()
        self.textField.text = " "
        self.textField.endEditing(true)
    }
    
    @IBAction func onEditButtonPressed(sender: UIBarButtonItem) {
        
        if(self.editing)
        {
            self.editing = false
            self.tableView.setEditing(false, animated: true)
            sender.title = "Edit"
        }
        else
        {
            self.editing = true
            self.tableView.setEditing(true, animated: true)
            sender.title = "Done"
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let toDoListItem = self.todoListArray.objectAtIndex(sourceIndexPath.row)
        
        self.todoListArray.removeObject(toDoListItem)
        self.todoListArray.insertObject(toDoListItem, atIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let alert = UIAlertController(title: "Delete it ?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        let alertAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default) { (action) -> Void in
            print("I love Frank")
            self.todoListArray .removeObjectAtIndex(indexPath.row)
            tableView .reloadData()
        }
        
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        cell?.textLabel?.text = todoListArray[indexPath.row] as? String
        return cell!
    }
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        print("right")
        
        let point = (sender.locationInView(self.tableView))
        let indexpath = (self.tableView.indexPathForRowAtPoint(point))
        let cell = (self.tableView.cellForRowAtIndexPath(indexpath!))
        
        if cell?.textLabel?.textColor == UIColor.blackColor(){
            cell?.textLabel?.textColor = UIColor.redColor()
        }
        else if cell?.textLabel?.textColor == UIColor.redColor(){
            cell?.textLabel?.textColor = UIColor.blueColor()
        }
        else if cell?.textLabel?.textColor == UIColor.blueColor(){
            cell?.textLabel?.textColor = UIColor.greenColor()
        }
        else if cell?.textLabel?.textColor == UIColor.greenColor(){
            cell?.textLabel?.textColor = UIColor.blackColor()
        }
    }
}

