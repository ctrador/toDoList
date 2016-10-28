//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Chad Trador on 10/24/16.
//  Copyright © 2016 Chad Trador. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
   
   @IBOutlet weak var toDoCatergoryLabel: UILabel!
    
    @IBOutlet weak var toDoTitleCell: UILabel!
    
    @IBOutlet weak var toDoDateCell: UILabel!
    
    @IBOutlet weak var toDoTextCell: UILabel!
    
    @IBOutlet weak var toDoDueDate: UILabel!
   
    weak var toDo: ToDo!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell(_ toDo: ToDo){
        
        self.toDo = toDo
        toDoTitleCell.text = toDo.title
        toDoTextCell.text = toDo.text
        toDoDateCell.text = toDo.dateString
        toDoDueDate.text = toDo.dueDate
        toDoCatergoryLabel.text = toDo.catergory
        
    }
        
    }

