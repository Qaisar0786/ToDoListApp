//
//  TableViewController.swift
//  ToDoListApp
//
//  Created by Qaisar Raza on 24/06/21.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var toDoList = [List]()
    
    // object of managed object context
    var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //fetching the content from core data
        let fetchRequest = NSFetchRequest<List>(entityName: "List")
        do{
            toDoList = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("could not fetch request", error)
        }
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoList.count
    }

    // table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        let list = toDoList[indexPath.row]
        cell.textLabel?.text = list.value(forKey: "title") as? String
        cell.detailTextLabel?.text = list.value(forKey: "titleDescription") as? String
        return cell
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //toDoList.remove(at: indexPath.row)
            managedContext.delete(toDoList[indexPath.row])
            
            do{
                try self.managedContext.save()
            }catch let error as NSError{
                print("not able to save",error)
            }
            
        }
        let fetchRequest = NSFetchRequest<List>(entityName: "List")
        do{
            toDoList = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("could not fetch request", error)
        }
        tableView.reloadData()
        
    }

  


 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController{
            
            let list = toDoList[indexPath.row]
           // vc.heading = list.title ?? ""
           // vc.detail = list.titleDescription ?? ""
            vc.selectedList = list
            self.navigationController?.pushViewController(vc , animated: true)
            
        }
    }
    

}
