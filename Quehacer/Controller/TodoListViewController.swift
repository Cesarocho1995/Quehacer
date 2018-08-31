//
//  ViewController.swift
//  Quehacer
//
//  Created by Cesar Enrique Mora Guerra on 8/28/18.
//  Copyright © 2018 Cesar Enrique Mora Guerra. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
// let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

   override func viewDidLoad()
    {   super.viewDidLoad()
        
/*        if let items = defaults.array(forKey: "TodoListArray") as? [Item]
        {
            itemArray = items
        }
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem1 = Item()
        newItem1.title = "Hola"
        itemArray.append(newItem1)

        let newItem2 = Item()
        newItem2.title = "como estas?"
        itemArray.append(newItem2)
 */
        loadItems()
    }
    
    
    
    

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
/*      LO MISMO QUE (cell.accessoryType = itemArray[indexPath.row].done == false ? .none : . checkmark)
        if itemArray[indexPath.row].done == false
        {
            cell.accessoryType = .none
        }
        else
        {
            cell.accessoryType = .checkmark
        }
*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == false ? .none : .checkmark
        
        return cell
    }
    
    
    
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true  )
    }
    
    
    
    
    
    //MARK - Boton de añadir
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Añade un Quehacer", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Añadir", style: .default)
        { (action) in
            //Que sucedera cuando le puchen
            //print(textField.text!)
            
            if textField.text != ""
            {
                //Esta linea guardaba en el User Default
                //self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                
                self.saveItems()
            }
            
        }
        
        alert.addTextField
        { (alertTextfield) in
            alertTextfield.placeholder = "Añada una tarea"
            textField = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }

    

    

    //MARK - Funcion de ayuda
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do
        {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch
        {
            print("Error, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    
    func loadItems ()
    {
        if let data = try? Data(contentsOf: dataFilePath!)
        {
            let decoder = PropertyListDecoder()
            do
            {
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch
            {
                print("Error \(error)")
            }
        }
    }
    
}
