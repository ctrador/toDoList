//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Chad Trador on 10/26/16.
//  Copyright © 2016 Chad Trador. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoStore.shared.getCount()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoTableViewCell.self)) as! ToDoTableViewCell
        
        cell.setupCell(ToDoStore.shared.getToDo(indexPath.row))
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoStore.shared.deleteToDo(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }
    }
    
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToDoSegue"{
            let toDoDetailVC = segue.destination as! ToDoDetailViewController
            let tableCell = sender as! ToDoTableViewCell
            toDoDetailVC.toDo = tableCell.toDo
            
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
        
    }
    
    // mark: unwind Segue
    
    @IBAction func saveToDoDetail(_ segue: UIStoryboardSegue) {
        let toDoDetailVC = segue.source as! ToDoDetailViewController
        if let indexpath = tableView.indexPathForSelectedRow {
            // ToDoStore.shared.updateToDo(toDoDetailVC.toDo, index: indexpath.row)
            ToDoStore.shared.sort()
            
            var indexPaths: [IndexPath] = []
            for index in 0...indexpath.row {
                indexPaths.append(IndexPath(row: index, section: 0))
                
            }
            
            
            
            tableView.reloadRows(at: indexPaths, with: .automatic)
            
        }else {
            
            ToDoStore.shared.addToDo(toDo: toDoDetailVC.toDo)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
    }
}
