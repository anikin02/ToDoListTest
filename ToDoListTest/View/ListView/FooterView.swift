//
//  FooterView.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 27.07.2025.
//

import SwiftUI

struct FooterView: View {
  @EnvironmentObject var viewModel: ListViewModel
  
  var body: some View {
    ZStack {
      Text(getStringCount(count: viewModel.filteredTasks.count))
        .font(.system(size: 18, weight: .regular))
        .foregroundStyle(.white)
      
      HStack {
        Spacer()
        
        NavigationLink {
          EditView()
            .environmentObject(viewModel)
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
    .background(.FOOTERCOLOR)
  }
  
  func getStringCount(count: Int) -> String {
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
