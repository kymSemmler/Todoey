//
//  CategoryViewController.swift
//  Todoey
//
//  Created by User on 17/6/19.
//  Copyright © 2019 kymsemmler. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategories()
        
        tableView.rowHeight = 80.0
        
    }

   //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        
        return cell
    }
    
    //MARK - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row] 
        }
    }
    
    
    // MARK - Add New Categorys
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What will happen when the user clicks the add item button
        
            let newCategory = Category()
            newCategory.name = textField.text!

            self.save(category: newCategory)
            
            
        }
       
        alert.addAction(action)
        
        alert.addTextField { (Field) in
            textField = Field
            textField.placeholder = "Add a new Category"
            }
        
        present(alert, animated: true, completion: nil)
    }
    
    //Mark - Data manipulation Methods
    
    func save(category: Category){
        
        do{
            
            try realm.write {
                realm.add(category)
            }
            
        } catch{
            print("Error saving category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        

       tableView.reloadData()
    }
    
    //MARK - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch {
                print("Error Deleting Category, \(error)")
            }
        }
    }
    
    //MARK - Search Bar Methods
    
    
    
}




    

    

    
    

    
    

    
    
    
    
    
    

