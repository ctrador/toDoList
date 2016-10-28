//
//  ToDoStore.swift
//  ToDoList
//
//  Created by Chad Trador on 10/24/16.
//  Copyright © 2016 Chad Trador. All rights reserved.
//

import UIKit


class ToDoStore {
    
    static let shared = ToDoStore()
    fileprivate var toDos : [ToDo]!
    
    var selectedImage: UIImage?
    
    init() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            
            toDos = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [ToDo]
        }else {
            toDos = []
            toDos.append(ToDo(catergory: "Work", title: "To Do 1", text: "This is a to do detail", dueDate: "12/31/20016 12:59"))
            toDos.append(ToDo(catergory: "home", title: "To Do 2", text: "This is a another to do detail", dueDate: "12/31/20016 12:59"))
            
            toDos.append(ToDo(catergory: "Other", title: "To Do 3", text: "This is a to do detail or is it", dueDate: "12/31/20016 12:59"))
            
            
            save()
        }
        
        sort()
        
    }
    
    //mark public functions
    
    
    func getToDo(_ index: Int)->ToDo {
        
        return toDos[index]
    }
    func addToDo(toDo: ToDo) {
        toDos.insert(toDo, at: 0)
    }
    
    func updateToDo(_ toDo: ToDo, index: Int)  {
        toDos[index] = toDo
    }
    func deleteToDo(_ index: Int) {
        toDos.remove(at: index)
    }
    func getCount()-> Int {
        return toDos.count
    }
    
    func save(){
        NSKeyedArchiver.archiveRootObject(toDos, toFile: archiveFilePath())
    }
    
    // **sort by date
    func sort() {
        toDos.sort { (toDo1, toDo2) -> Bool in
            return toDo1.date.compare(toDo2.date) == .orderedDescending
            
        }
    }
    // Mark - Private Functions
    
    
    fileprivate func archiveFilePath() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appending("ToDoStore.plist")
        return path
        
    }
}



