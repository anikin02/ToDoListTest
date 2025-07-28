//
//  EditView.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI

struct EditView: View {
  @Environment(\.dismiss) private var dismiss
  @ObservedObject var editViewModel: EditViewModel
  @EnvironmentObject var listViewModel: ListViewModel
  
  init(item: TodoItem? = nil) {
    editViewModel = EditViewModel(item: item)
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      TextField("Введите название", text: $editViewModel.todo)
        .font(.system(size: 34, weight: .bold))
        .foregroundStyle(.TEXTCOLOR)
      Text(editViewModel.date)
        .foregroundStyle(.GRAY)
      VStack {
        ZStack(alignment: .topLeading) {
          if editViewModel.details.isEmpty {
            Text("Введите описание")
              .font(.system(size: 20, weight: .regular))
              .foregroundStyle(.gray)
          }
          
          TextEditor(text: $editViewModel.details)
            .font(.system(size: 20, weight: .regular))
            .foregroundStyle(.TEXTCOLOR)
            .opacity(editViewModel.details.isEmpty ? 0.25 : 1)
        }
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          if let item = editViewModel.item {
            listViewModel.changeTask(item: item,
                                     todo: editViewModel.todo,
                                     details: editViewModel.details)
          } else if !editViewModel.todo.isEmpty {
            listViewModel.addTask(
              todo: editViewModel.todo,
              details: editViewModel.details
            )
          }
          dismiss()
        } label: {
          HStack {
            Image(systemName: "chevron.left")
            Text("Назад")
          }
          .foregroundColor(.YELLOW)
        }
      }
    }
  }
}

#Preview {
  EditView()
}
