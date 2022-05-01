//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Qaisar Raza on 24/06/21.
//

import UIKit
import CoreData



class ViewController: UIViewController {

    // object of managed object context
    var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var message: UILabel!
    
    //var heading = ""
    //var detail = ""
    var selectedList : List?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Add Details"
        message.text = ""
        if (selectedList != nil){
            titleField.text = selectedList?.title
            descriptionField.text = selectedList?.titleDescription
            button.setTitle("Update", for: .normal)
            title = "Update Details"
        }
        
    }

    
    


    @IBAction func saveAction(_ sender: UIButton) {
        //when adding data
        if( selectedList == nil){
        //storing data into the core data
        let entity = NSEntityDescription.insertNewObject(forEntityName: "List", into: managedContext)
        //setting data into the entities
        entity.setValue(titleField.text, forKey: "title")
        entity.setValue(descriptionField.text, forKey: "titleDescription")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Not able to save",error)
        }
            message.text = "Successfully Added"
        
        //going back to table view controller
        dismiss(animated: true, completion: nil)
        }
        //when updating data
        else{
            let fetchRequest = NSFetchRequest<List>(entityName: "List")
            do{
                let results: NSArray = try managedContext.fetch(fetchRequest) as NSArray
                for result in results{
                     let list = result as! List
                     if(list == selectedList){
                        list.title = titleField.text
                        list.titleDescription = descriptionField.text
                        try managedContext.save()
                        
                        message.text = "Successfully Updated"
                        dismiss(animated: true, completion: nil)
                     }
                }
            }catch let error as NSError{
                print("could not fetch request", error)
            }
           
        }
    }
    
    
}

