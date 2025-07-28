//
//  ListViewModel.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI

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
  
  init() {
    loadTasks()
  }
  
  func loadTasks() {
    if UserDefaults.standard.bool(forKey: "hasLaunchedBefore") == false {
      DispatchQueue.main.async {
        APIManager.shared.getTodos { [weak self] items in
          for item in items.todos {
            self?.tasks.insert(TodoItem(todo: item.todo, description: item.todo, completed: item.completed), at: 0)
          }
        }
      }
      //UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    } else {
      // CORE DATA
    }
    
    filteredTasks = tasks
  }
  
  func addTask(item: TodoItem) {
    DispatchQueue.main.async {
      self.tasks.insert(item, at: 0)
    }
  }
  
  func removeTask(item: TodoItem) {
    DispatchQueue.main.async {
      if let index = self.tasks.firstIndex(of: item) {
        self.tasks.remove(at: index)
      }
    }
  }
  
  func changeTask(item: TodoItem, todo: String, description: String) {
    DispatchQueue.main.async {
      if let index = self.tasks.firstIndex(of: item) {
        self.tasks[index].todo = todo
        self.tasks[index].description = description
      }
    }
  }
  
  func changeCompletedTask(item: TodoItem) {
    DispatchQueue.main.async {
      if let index = self.tasks.firstIndex(of: item) {
        self.tasks[index].completed.toggle()
      }
    }
  }
  
  func filterTasks() {
    DispatchQueue.main.async {
      if self.searchText.isEmpty {
        self.filteredTasks = self.tasks
      } else {
        self.filteredTasks = self.tasks.filter { $0.todo.lowercased().contains(self.searchText.lowercased()) }
      }
    }
  }
  
}
