//
//  ViewController.swift
//  Quehacer
//
//  Created by Cesar Enrique Mora Guerra on 8/28/18.
//  Copyright © 2018 Cesar Enrique Mora Guerra. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Hola"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "como estas?"
        itemArray.append(newItem2)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String]
//        {
//            itemArray = items
//        }
        
    }
    
    
    
    

    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == false ? .none : . checkmark

//      LO MISMO QUE LA LINEA DE ARRIBA
//        if itemArray[indexPath.row].done == false
//        {
//            cell.accessoryType = .none
//        }
//        else
//        {
//            cell.accessoryType = .checkmark
//        }
        
        return cell
    }
    
    
    
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true  )
    }
    
    
    
    
    
    //MARK - Boton de añadir
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Añade un Quehacer", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Añadir", style: .default) { (action) in
            //Que sucedera cuando le puchen
            print(textField.text!)
            
            if textField.text != ""
            {
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Añada una tarea"
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    


}

