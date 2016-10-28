//
//  ToDoDetailViewController.swift
//  ToDoList
//
//  Created by Chad Trador on 10/26/16.
//  Copyright © 2016 Chad Trador. All rights reserved.
//

import UIKit

class ToDoDetailViewController:
UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var catergoryPickerLabel: UILabel!
    
    @IBOutlet weak var catergoryPicker: UIPickerView!
    
    @IBOutlet weak var toDoTitleField: UITextField!
    
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    @IBOutlet weak var toDoTimeAndDate: UILabel!
    
    @IBOutlet weak var toDoCatergoryField: UITextField!
    
    @IBOutlet weak var toDoTextViewField: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var gestureRecognizer: UITapGestureRecognizer!
    var catergoryArray = ["Home", "Work", "Other"]
    var toDo = ToDo()
    var catergorySelection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catergoryPicker.delegate = self
        catergoryPicker.dataSource = self
        toDoCatergoryField.text = toDo.catergory
        toDoTitleField.text = toDo.title
        toDoTextViewField.text = toDo.text
        selectedDateLabel.text = toDo.dueDate
        catergoryPickerLabel.text = toDo.catergory
        
        if let image = toDo.image {
            imageView.image = image
            
        }else {
            imageView.isHidden = true
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catergoryArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catergoryArray.count
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        catergorySelection = row
    }
    func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(viewImage))
        
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage()   {
        if let image = imageView.image {
            ToDoStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
            
        }
    }
    
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        toDo.title = toDoTitleField.text!
        toDo.text = toDoTextViewField.text
        toDo.date = Date()
        toDo.image = imageView.image
        toDo.dueDate = selectedDateLabel.text!
        toDo.catergory = toDoCatergoryField.text!
        
    }
    
    // MARK: IBActions
    
    @IBAction func datePicker(_ sender: AnyObject) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        var strDate = dateFormatter.string(from: todoDatePicker.date)
        self.selectedDateLabel.text = strDate
    }
    
    
    
    @IBAction func chosePhoto(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "picture", message: "Chose a picture typr", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "camera", style: .default, handler: { (action) in self.showPicker(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in self.showPicker(.photoLibrary)
        }))
        present(alert, animated: true, completion:  nil)
    }
}

// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
// if segue.identifier == "EditNotSegue" {
//let toDoDetailVC = segue.destination as! toDoDetailViewController
//  let tableCell = sender as! ToDoTableViewCell
//toDoDetailVC.toDo = tableCell.toDo

//}// use this to access camra on phone I Pad


extension ToDoDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0 ,y: 0, width: maxSize, height: newHeight ))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            imageView.image = resizedImage
            
            imageView.isHidden = false
            
            if gestureRecognizer != nil {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}


