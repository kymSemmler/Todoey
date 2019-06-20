//
//  CategoryViewController.swift
//  Todoey
//
//  Created by User on 17/6/19.
//  Copyright © 2019 kymsemmler. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategories()
        
    }

   //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    //MARK - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    // MARK - Add New Categorys
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What will happen when the user clicks the add item button
        
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            

            self.categories.append(newCategory)

            self.saveCategories()
            
            
        }
       
        alert.addAction(action)
        
        alert.addTextField { (Field) in
            textField = Field
            textField.placeholder = "Add a new Category"
            }
        
        present(alert, animated: true, completion: nil)
    }
    
    //Mark - Data manipulation Methods
    
    func saveCategories(){
        
        do{
            
            try context.save()
            
        } catch{
            print("Error saving category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(){
        
    let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error Loading Categories \(print)")
        }
        
        tableView.reloadData()
    }
    
    //MARK - Search Bar Methods
    
    
    
}
    

    

    
    

    
    

    
    
    
    
    
    

