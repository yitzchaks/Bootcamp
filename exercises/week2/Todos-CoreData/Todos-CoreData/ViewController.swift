//
//  ViewController.swift
//  Todos-CoreData
//
//  Created by Yitzchak Schechter on 20/06/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    // Action to add a new todo item
    @IBAction func addToDo(_ sender: UIBarButtonItem) {
        addTodoAlert()
    }
    
    var todos:[Todo]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func fetchTodos() {
        do {
            self.todos = try context.fetch(Todo.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            print("Error fetchTodos")
        }
    }
    
    // Setup the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch all todos from core data
        fetchTodos()
        self.title = "Todos app"
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // Invalidate collection view layout when subviews layout changes
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func addTodoAlert() {
        let alert = UIAlertController(title: "Add To-Do", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "New To-Do Item"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {_ in
            guard let textField = alert.textFields?.first?.text else {
                return
            }
            self.addTodo(text: textField)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addTodo(text: String) {
        let addTodo = Todo(context: self.context)
        addTodo.title = text
        addTodo.color = stringToColor(text).toString
        
        do {
          try  self.context.save()
        } catch {
            print("Error addTodo")
        }
        self.fetchTodos()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCall", for: indexPath) as! CollectionViewCell
        guard let todo = todos?[indexPath.row] else { return cell }
        cell.setup(todo)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        // Calculate width of each cell based on collection view width and spacing
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = 100
        return CGSize (width: width, height: height)
    }
}

func stringToColor(_ string: String) -> UIColor {
    var hash = 0
    for i in string.utf16 {
        hash = Int(i) &+ ((hash << 5) &- hash)
    }
    let red = CGFloat((hash >> 16) & 0xFF) / 255.0
    let green = CGFloat((hash >> 8) & 0xFF) / 255.0
    let blue = CGFloat(hash & 0xFF) / 255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 0.8)
}

extension UIColor {
    // Converting UIColor to string by CIColor.stringRepresentation
    var toString : String {
        let ciColor = CIColor(color: self)
        return ciColor.stringRepresentation
    }
}

extension String {
    // Converting string to UIColor by CIColor
    var toColor : UIColor {
        let ciColor = CIColor(string: self)
        return UIColor(ciColor: ciColor)
    }
}
