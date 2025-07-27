//
//  ContentView.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      ListView()
        .navigationTitle(Text("Задачи"))
    }
  }
}

#Preview {
  ContentView()
}
