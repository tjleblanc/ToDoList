//
//  ToDoListViewController
//  ToDoList
//
//  Created by Thomas LeBlanc on 5/7/19.
//  Copyright © 2019 AnyoneCanInvest. All rights reserved.
//

import UIKit
import CoreData

let itemArrayKeyStr = "ToDoListArray"

class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        // Do any additional setup after loading the view.
        loadItems()
    }
    //Mark Tableview Datasource Methods
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
    
    //Mark TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
#if deleteItem
        // remove an item from the  context and list
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
#else
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
#endif
        
        saveItemsToContext()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the user hits the Add Item button on our UIAlert
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            self.saveItemsToContext()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model manipulation methods
    
    func saveItemsToContext() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }

    // extrnal parameter: with
    // internal parameter: request
    func loadItems(with request: NSFetchRequest<Item>=Item.fetchRequest()) {
        do {
            itemArray =  try context.fetch(request)
        }
        catch {
            print("Error fetching dsta from context \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Search bar methods
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        }
    }
}
