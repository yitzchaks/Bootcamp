//
//  ViewController.swift
//  TODOs
//
//  Created by Yitzchak Schechter on 18/06/2023.
//

import UIKit

class ViewController: UIViewController {
    // List of todo items
    private var todos: [Todo] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Action to add a new todo item
    @IBAction func addToDo(_ sender: UIBarButtonItem) {
        // Create an alert to add new todo item
        addTodoAlert()
    }
    
    // Setup the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set collection view data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // Invalidate collection view layout when subviews layout changes
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func addTodoAlert() {
        // Create an alert with a text field to input new todo item
        let alert = UIAlertController(title: "Add To-Do", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "New To-Do Item"
        }
        // Add the new todo item to the list and reload the collection view
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {_ in
            guard let textField = alert.textFields?.first?.text else {
                return
            }
            self.addTodo(text: textField)
        }))
        // Add cancel action to the alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addTodo(text: String) {
        let todo = Todo(text)
        self.todos.append(todo)
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    // Return number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todos.count
    }
    
    // Configure cell for each item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCall", for: indexPath) as! CollectionViewCell
        // Set todo for cell
        let todo = todos[indexPath.row]
        cell.setup(todo)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // Determine size for each item cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Number of columns in the collection view
        let columns: CGFloat = 2
        // Calculate width of each cell based on collection view width and spacing
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = floor(adjustedWidth / columns)
        // Set height for each cell
        let height: CGFloat = 100
        return CGSize (width: width, height: height)
    }
}
