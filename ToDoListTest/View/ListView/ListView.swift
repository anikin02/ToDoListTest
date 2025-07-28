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
              .contextMenu(menuItems: {
                contextMenuItems(for: item)
              }, preview: {
                taskPreview(for: item)
              })
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
  
  
  @ViewBuilder
  private func contextMenuItems(for item: TodoItem) -> some View {
    NavigationLink {
      EditView(item: item)
        .environmentObject(viewModel)
    } label: {
      Label("Редактировать", systemImage: "square.and.pencil")
    }
    
    Button {
      shareItem(item: item)
    } label: {
      Label("Поделиться", systemImage: "square.and.arrow.up")
    }
    
    Button(role: .destructive) {
      viewModel.removeTask(item: item)
    } label: {
      Label("Удалить", systemImage: "trash")
    }
  }
  
  private func taskPreview(for item: TodoItem) -> some View {
    let screenWidth = UIScreen.main.bounds.width
    return VStack(alignment: .leading, spacing: 8) {
      Text(item.todo!)
        .foregroundStyle(.white)
        .font(.system(size: 20, weight: .medium))
      Text(item.details!)
        .foregroundStyle(.white)
        .font(.system(size: 16, weight: .regular))
      Text(item.date!)
        .foregroundStyle(.WHITE)
        .font(.system(size: 16, weight: .regular))
    }
    .padding(20)
    .frame(width: screenWidth-20, alignment: .leading)
    .background(.CONTEXTCOLOR)
  }
  
  private func shareItem(item: TodoItem) {
    let textToShare = "\(item.todo ?? "SMTH wrong")\n\(item.details ?? "SMTH wrong")"
    
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
