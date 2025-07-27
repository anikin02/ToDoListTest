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
        ForEach(viewModel.filteredTasks, id: \.self) { item in
          NavigationLink {
            EditView(item: item)
              .environmentObject(viewModel)
          } label: {
            ItemListView(item: item)
              .environmentObject(viewModel)
              .contextMenu {
                NavigationLink {
                  EditView(item: item)
                    .environmentObject(viewModel)
                } label: {
                  Label("Редактировать", systemImage: "doc.on.doc")
                }
                Button {
                  shareItem(item: item)
                } label: {
                  Label("Поделиться", systemImage: "doc.on.doc")
                }
                Button(role: .destructive) {
                  viewModel.removeTask(item: item)
                } label: {
                  Label("Удалить", systemImage: "trash")
                }
              } preview: {
                let screenWidth = UIScreen.main.bounds.width
                VStack(alignment: .leading, spacing: 8) {
                  Text(item.todo)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .medium))
                  Text(item.description)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .regular))
                  Text(item.date)
                    .foregroundStyle(.WHITE)
                    .font(.system(size: 16, weight: .regular))
                }
                .padding(20)
                .frame(width: screenWidth, alignment: .leading)
                .background(.FOOTERCOLOR)
                .cornerRadius(12)
                .padding(.horizontal, 20)
              }
            
          }
          Divider()
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 20)
      .scrollIndicators(.hidden)
      .searchable(text: $viewModel.searchText)
      
      FooterView()
        .environmentObject(viewModel)
    }
  }
  
  private func shareItem(item: TodoItem) {
      let textToShare = "\(item.todo)\n\(item.description)"
      
      let activityViewController = UIActivityViewController(
          activityItems: [textToShare],
          applicationActivities: nil
      )
      
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let window = windowScene.windows.first,
         let rootViewController = window.rootViewController {
          
          if UIDevice.current.userInterfaceIdiom == .pad {
              activityViewController.popoverPresentationController?.sourceView = rootViewController.view
              activityViewController.popoverPresentationController?.sourceRect = CGRect(
                  x: UIScreen.main.bounds.width / 2,
                  y: UIScreen.main.bounds.height / 2,
                  width: 0,
                  height: 0
              )
          }
          
          rootViewController.present(activityViewController, animated: true)
      }
  }
}


#Preview {
  ContentView()
}
