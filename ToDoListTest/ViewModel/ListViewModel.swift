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
    tasks = [
      TodoItem(todo: "Название", description: "описвание задачи", completed: true),
      TodoItem(todo: "Название", description: "описвание задачи", completed: false),
      TodoItem(todo: "Привет", description: "описвание задачи", completed: false),
      TodoItem(todo: "Название", description: "описвание задачи", completed: true),
      TodoItem(todo: "Пока", description: "описвание задачи", completed: false),
      TodoItem(todo: "Название", description: "описвание задачи", completed: true),
      TodoItem(todo: "Почему", description: "описвание задачи", completed: false),
      TodoItem(todo: "Название", description: "описвание задачи", completed: true)
    ]
    
    filteredTasks = tasks
  }
  
  func addTask(item: TodoItem) {
    tasks.insert(item, at: 0)
  }
  
  func removeTask(item: TodoItem) {
    if let index = tasks.firstIndex(of: item) {
      tasks.remove(at: index)
    }
  }
  
  func changeTask(item: TodoItem, todo: String, description: String) {
    if let index = tasks.firstIndex(of: item) {
      tasks[index].todo = todo
      tasks[index].description = description
    }
  }
  
  func changeCompletedTask(item: TodoItem) {
    if let index = tasks.firstIndex(of: item) {
      tasks[index].completed.toggle()
    }
  }
  
  func filterTasks() {
    if searchText.isEmpty {
      filteredTasks = tasks
    } else {
      filteredTasks = tasks.filter { $0.todo.lowercased().contains(searchText.lowercased()) }
    }
  }
  
}
