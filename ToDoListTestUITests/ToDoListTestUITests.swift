//
//  ToDoListTestUITests.swift
//  ToDoListTestUITests
//
//  Created by Данил Аникин on 29.07.2025.
//

import Testing
import CoreData
@testable import ToDoListTest

struct ToDoListTestUITests {
  func makeInMemoryPersistentContainer() -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "TasksModel")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [description]
    
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Failed to load store: \(error)")
      }
    }
    return container
  }
  
  @Test func testAddTask() async throws {
    let viewModel = ListViewModel(container: makeInMemoryPersistentContainer())
    
    let initialCount = viewModel.tasks.count
    viewModel.addTask(todo: "Test task", details: "Some details")
    
    try await Task.sleep(nanoseconds: 5_000_000_000)
    
    #expect(viewModel.tasks.count == initialCount + 1)
    #expect(viewModel.tasks.last?.todo == "Test task")
  }
  
  
  @Test func testRemoveTask() async throws {
    let viewModel = ListViewModel(container: makeInMemoryPersistentContainer())
    
    viewModel.addTask(todo: "To be removed", details: "Temporary")
    try await Task.sleep(nanoseconds: 5_000_000_000)
    
    guard let item = viewModel.tasks.last else {
      print("No task found to remove.")
      return
    }
    
    let initialCount = viewModel.tasks.count
    viewModel.removeTask(item: item)
    try await Task.sleep(nanoseconds: 5_000_000_000)
    
    #expect(viewModel.tasks.count == initialCount - 1)
  }
  
  @Test func testChangeTask() async throws {
    let viewModel = ListViewModel(container: makeInMemoryPersistentContainer())
    
    viewModel.addTask(todo: "Original", details: "Old details")
    try await Task.sleep(nanoseconds: 5_000_000_000)
    
    guard let item = viewModel.tasks.last else {
      print("No task found to modify.")
      return
    }
    
    viewModel.changeTask(item: item, todo: "Updated", details: "New details")
    try await Task.sleep(nanoseconds: 5_000_000_000)
    
    #expect(item.todo == "Updated")
    #expect(item.details == "New details")
  }
  
  @Test func testFiltering() async throws {
    let viewModel = ListViewModel(container: makeInMemoryPersistentContainer())
    
    viewModel.addTask(todo: "Buy milk", details: "")
    try await Task.sleep(nanoseconds: 2_000_000_000)
    viewModel.addTask(todo: "Read book", details: "")
    try await Task.sleep(nanoseconds: 2_000_000_000)
    viewModel.addTask(todo: "Buy bread", details: "")
    try await Task.sleep(nanoseconds: 2_000_000_000)
    
    viewModel.searchText = "buy"
    viewModel.filterTasks()
    try await Task.sleep(nanoseconds: 5_000_000_000)
    
    #expect(viewModel.filteredTasks.count == 2)
    #expect(viewModel.filteredTasks.allSatisfy { $0.todo?.lowercased().contains("buy") ?? false })
  }
  
}

