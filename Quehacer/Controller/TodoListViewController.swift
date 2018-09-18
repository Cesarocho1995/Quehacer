//
//  ViewController.swift
//  Quehacer
//
//  Created by Cesar Enrique Mora Guerra on 8/28/18.
//  Copyright © 2018 Cesar Enrique Mora Guerra. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    //MARK: - Variables Globales
    let realm = try! Realm()
    var todoItems: Results<Item>?
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
   
    
    
    // MARK: - Cuando Arranca la Aplicacion
   override func viewDidLoad()
    {   super.viewDidLoad()
    
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    
    

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]
        {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else
        {
            cell.textLabel?.text = "No Existe Ninguna Tarea"
        }
        
        
        
        return cell
    }
    
    
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let item = todoItems?[indexPath.row]
        {
            do
            {
                try realm.write {
                    item.done = !item.done
                    //realm.delete(item)
                    
                }
            }
            catch
            {
                print("Error marcando la casilla \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true  )
    }
    
    
    
    
    
    //MARK: - Boton de añadir
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Añade un Quehacer", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Añadir", style: .default)
        { (action) in
            //Que sucedera cuando le puchen
            
            if textField.text != ""
            {
                if let currentCategory = self.selectedCategory
                {
                    do
                    {
                        try self.realm.write
                        {
                            let newItem = Item()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    }
                    catch
                    {
                        print("Error guardando tareas \(error)")
                    }
                }
                self.tableView.reloadData()
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

    

    

    //MARK: - Funcion de ayuda
    
    
    func loadItems ()
    {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
}




//MARK: - Metodos SearchBar
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text?.count == 0
        {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
        else
        {
            todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            tableView.reloadData()
        }
    }
    
    
    
}
