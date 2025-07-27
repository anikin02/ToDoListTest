//
//  TodoItem.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import Foundation

struct TodoItem {
  let todo: String
  let description: String
  let completed: Bool
  let date: String
  
  init(todo: String, description: String = "", completed: Bool = false, date: String? = nil) {
    self.todo = todo
    self.description = description
    self.completed = completed
    
    if let date = date {
      self.date = date
    } else {
      let currentDate = Date()
      
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yy"
      formatter.locale = Locale(identifier: "en_US_POSIX")
      
      let formattedDate = formatter.string(from: currentDate)
      self.date = formattedDate
    }
    
  }
}
