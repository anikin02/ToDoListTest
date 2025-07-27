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
        ItemListView()
        ItemListView()
        ItemListView()
        ItemListView()
      }
      .frame(maxWidth: .infinity)
      
      HStack {
        
      }
    }
  }
}

struct ItemListView: View {
  var body: some View {
    HStack {
      HStack {
        
      }
      VStack {
        
      }
    }
  }
}
