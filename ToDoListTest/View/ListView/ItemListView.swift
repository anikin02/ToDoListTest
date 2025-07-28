//
//  ItemListView.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI

struct ItemListView: View {
  @EnvironmentObject var viewModel: ListViewModel
  
  let item: TodoItem
  var body: some View {
    HStack(alignment: .top) {
      HStack {
        Button {
          viewModel.changeCompletedTask(item: item)
        } label: {
          Image(systemName: item.completed ? "checkmark.circle" : "circle")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(item.completed ? .YELLOW : .GRAY)
        }
      }
      VStack(alignment: .leading) {
        Text(item.todo ?? "Wait pls")
          .font(.system(size: 22, weight: .medium))
          .foregroundStyle(item.completed ? .GRAY : .TEXTCOLOR)
          .lineLimit(1)
          .strikethrough(item.completed, color: .GRAY)
        Text(item.details ?? "Wait pls")
          .lineLimit(2)
          .multilineTextAlignment(.leading)
          .font(.system(size: 16, weight: .regular))
          .foregroundStyle(item.completed ? .GRAY : .TEXTCOLOR)
        Text(item.date ?? "Wait pls")
          .foregroundStyle(.GRAY)
          .font(.system(size: 16, weight: .regular))
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
