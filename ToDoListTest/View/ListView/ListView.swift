//
//  ListView.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI

struct ListView: View {
  
  @ObservedObject var viewModel = ListViewModel()
  
  var body: some View {
    VStack {
      ScrollView {
        ItemListView(item: TodoItem(todo: "Название", description: "описвание задачи", completed: false))
        ItemListView(item: TodoItem(todo: "Название Название Название Название Название", description: "описвание задачи", completed: false))
        ItemListView(item: TodoItem(todo: "Название", description: "описвание задачи", completed: true))
        ItemListView(item: TodoItem(todo: "Название", description: "описвание задачи", completed: false))
        ItemListView(item: TodoItem(todo: "Название", description: "описваниеопис ваниеоп исвание описваниео писваниеописвание описвание задачи ", completed: true))
        ItemListView(item: TodoItem(todo: "Название", description: "описваниеопис ваниеоп исвание описваниео писваниеописвание описвание задачи ", completed: true))
        ItemListView(item: TodoItem(todo: "Название", description: "описваниеопис ваниеоп исвание описваниео писваниеописвание описвание задачи ", completed: true))
        ItemListView(item: TodoItem(todo: "Название", description: "описваниеопис ваниеоп исвание описваниео писваниеописвание описвание задачи ", completed: true))
        ItemListView(item: TodoItem(todo: "Название", description: "описваниеопис ваниеоп исвание описваниео писваниеописвание описвание задачи ", completed: true))
        ItemListView(item: TodoItem(todo: "Название", description: "описваниеопис ваниеоп исвание описваниео писваниеописвание описвание задачи ", completed: true))
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 20)
      .scrollIndicators(.hidden)
      
      FooterView(count: 7)
    }
  }
}

struct FooterView: View {
  let count: Int
  var body: some View {
    ZStack {
      Text(getStringCount())
        .font(.system(size: 18, weight: .regular))
        .foregroundStyle(.white)
      
      HStack {
        Spacer()
        
        Button {
        } label: {
          Image(systemName: "square.and.pencil")
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundStyle(.YELLOW)
        }
      }
      .padding(.horizontal, 20)
    }
    .frame(maxWidth: .infinity, minHeight: 50)
    .background(Color.black.opacity(0.5))
  }
  
  func getStringCount() -> String {
    switch count {
    case 1:
      return "1 Задача"
    case 2..<5:
      return "\(count) Задачи"
    default:
      return "\(count) Задач"
    }
  }
}


#Preview {
  ContentView()
}
