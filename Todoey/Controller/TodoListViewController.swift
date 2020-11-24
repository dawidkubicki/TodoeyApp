//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newItem1 = Item()
//        newItem1.title = "Find Gibson"
//        itemArray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "Find Gibson"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Find Gibson"
//        itemArray.append(newItem3)
//
//        let newItem4 = Item()
//        newItem4.title = "Find Gibson"
//        itemArray.append(newItem4)
        
        loadItems()
        
    }
    
    //MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegates methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //how to get the opposite (works like a toggle with the boolean)
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
  
        //how to delete
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    
    //MARK: - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todo", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen when user clicks add item in alert
            //self.itemArray.append(textField.text!)
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = !false
            
            self.itemArray.append(newItem)
         
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    //MARK: - Save to plist func
    
    func saveItems(){
        do {
            try context.save()
        } catch {
            print("error saving context, \(error)")
        }

        
        self.tableView.reloadData()
    }
    
    
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error while fetching: \(error)")
        }
    }
}


