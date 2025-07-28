//
//  ListViewModel.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI
import CoreData

class ListViewModel: ObservableObject {
  var tasks = [TodoItem]() {
    didSet {
      filterTasks()
    }
  }
  @Published var filteredTasks = [TodoItem]()
  @Published var searchText = String() {
    didSet {
      filterTasks()
    }
  }
  
  let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "TasksModel")
    container.loadPersistentStores { (description, error) in
      if let error = error {
        print(error)
      }
    }
    
    loadTasks()
  }
  
  init(container: NSPersistentContainer) {
    self.container = container
  }
  
  func fetchTasks() {
    let request = NSFetchRequest<TodoItem>(entityName: "TodoItem")
    
    do {
      tasks = try container.viewContext.fetch(request)
      filterTasks()
    } catch let error {
      print(error)
    }
  }
  
  func loadTasks() {
    if UserDefaults.standard.bool(forKey: "hasLaunchedBefore") == false {
      DispatchQueue.main.async {
        APIManager.shared.getTodos { [weak self] items in
          for item in items.todos {
            self?.addTask(todo: item.todo, details: item.todo, complited: item.completed)
          }
        }
      }
      UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    } else {
      fetchTasks()
    }
    
    filterTasks()
  }
  
  func addTask(todo: String, details: String, complited: Bool = false) {
    DispatchQueue.main.async {
      let newTask = TodoItem(context: self.container.viewContext)
      newTask.todo = todo
      newTask.details = details
      newTask.completed = complited
      newTask.id = UUID()
      
      let currentDate = Date()
      
      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yy"
      formatter.locale = Locale(identifier: "en_US_POSIX")
      
      let formattedDate = formatter.string(from: currentDate)
      newTask.date = formattedDate
      
      self.saveData()
    }
  }
  
  func saveData() {
    do {
      try container.viewContext.save()
      fetchTasks()
    } catch let error {
      print(error)
    }
  }
  
  func removeTask(item: TodoItem) {
    DispatchQueue.main.async {
      if let index = self.tasks.firstIndex(of: item) {
        self.container.viewContext.delete(self.tasks[index])
        self.saveData()
      }
    }
  }
  
  func changeTask(item: TodoItem, todo: String, details: String) {
    DispatchQueue.main.async {
      item.todo = todo
      item.details = details
      self.saveData()
    }
  }
  
  func changeCompletedTask(item: TodoItem) {
    DispatchQueue.main.async {
      item.completed.toggle()
      self.saveData()
    }
  }
  
  func filterTasks() {
    DispatchQueue.main.async {
      if self.searchText.isEmpty {
        self.filteredTasks = self.tasks.reversed()
      } else {
        self.filteredTasks = self.tasks.filter { $0.todo!.lowercased().contains(self.searchText.lowercased()) }
      }
    }
  }
  
}
