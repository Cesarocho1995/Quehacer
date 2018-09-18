//
//  CategoryController.swift
//  Quehacer
//
//  Created by Cesar Enrique Mora Guerra on 9/10/18.
//  Copyright © 2018 Cesar Enrique Mora Guerra. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryController: UITableViewController {
    
    //MARK: - Variables y Constantes
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

    }
    
    
    
    //MARK: - Metodos de TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "Ninguna coleccion Agregada aun"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
    
    
    
    //MARK: - Funcion Cargar
    func loadItems ()
    {
        categoryArray = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    
    
    //MARK: - Funcion Guardar
    func save(category: Category)
    {
        do
        {
            try realm.write {
                realm.add(category)
            }
        }
        catch
        {
            print("Error saving \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    // MARK: - Accion del Boton
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Añade una Coleccion", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Añadir", style: .default)
        { (action) in
            
            if textField.text != ""
            {
                let newCategory = Category()
                newCategory.name = textField.text!
        
                self.save(category: newCategory)
            }
            
        }
        
        alert.addTextField
            { (alertTextfield) in
                alertTextfield.placeholder = "Añada una Coleccion"
                textField = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}
