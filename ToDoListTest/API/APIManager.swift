//
//  APIManager.swift
//  ToDoListTest
//
//  Created by Данил Аникин on 28.07.2025.
//

import Foundation

class APIManager {
  static let shared = APIManager()
  
  func getTodos(completion: @escaping (APIItems) -> Void) {
      let urlString: String = "https://dummyjson.com/todos"
      guard let url = URL(string: urlString) else { return }
    
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
        if error != nil {
          print(error!.localizedDescription)
        } else if let data = data {
          do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(APIItems.self, from: data)
            completion(response)
          } catch {
            print(error.localizedDescription)
          }
        }
      })
      task.resume()
    }
  }

  struct APIItem: Decodable, Equatable {
    let todo: String
    let completed: Bool
  }


  struct APIItems: Decodable {
    var todos: [APIItem]
  }
