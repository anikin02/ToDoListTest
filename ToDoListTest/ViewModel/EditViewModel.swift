//
//  EditViewModel.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI

class EditViewModel: ObservableObject {
  @Published var todo: String = ""
  @Published var details: String = ""
  @Published var date: String = ""
  
  var item: TodoItem?
  
  init(item: TodoItem? = nil) {
    self.item = item
    
    self.todo = item?.todo ?? ""
    self.details = item?.details ?? ""
    if let date = item?.date {
      self.date = date
    } else {
      let currentDate = Date()
      
      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yy"
      formatter.locale = Locale(identifier: "en_US_POSIX")
      
      let formattedDate = formatter.string(from: currentDate)
      self.date = formattedDate
    }
  }
}
