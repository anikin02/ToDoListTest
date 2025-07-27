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
}


#Preview {
  ContentView()
}
