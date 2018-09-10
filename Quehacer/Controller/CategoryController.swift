//
//  CategoryController.swift
//  Quehacer
//
//  Created by Cesar Enrique Mora Guerra on 9/10/18.
//  Copyright © 2018 Cesar Enrique Mora Guerra. All rights reserved.
//

import UIKit
import CoreData

class CategoryController: UITableViewController {
    
    //MARK: - Variables y Constantes
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

    }
    
    
    
    //MARK: - Metodos de TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
    
    
    //MARK: - Funcion Cargar
    func loadItems (with request: NSFetchRequest<Category> = Category.fetchRequest())
    {
        do
        {
            categoryArray = try context.fetch(request)
        }
        catch
        {
            print("Error cargando Colecciones \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    //MARK: - Funcion Guardar
    func saveItems ()
    {
        do
        {
            try context.save()
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
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                self.categoryArray.append(newCategory)
                self.saveItems()
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
