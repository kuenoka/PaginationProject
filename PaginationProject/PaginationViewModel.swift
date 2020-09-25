//
//  PaginationViewModel.swift
//  PaginationProject
//
//  Created by Kingsley Enoka on 9/21/20.
//  Copyright © 2020 Kingsley Enoka. All rights reserved.
//

import Foundation

class PaginationViewModel {
  
  static let shared = PaginationViewModel()
  private var items: [Item] = []
  private var totalCount = 0
  
  func getData(page: Int, completion: @escaping ()->()) {
    
    let urlString = "https://api.github.com/search/users?q=a&page=\(page)&per_page=20"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      guard error == nil, let data = data else { return }
      
      do {
        
        let model = try JSONDecoder().decode(PaginationModel.self, from: data)
        self.items.append(contentsOf: model.items)
        self.totalCount = model.total_count
        
        DispatchQueue.main.async {
          completion()
        }
        
      } catch {
        print(error.localizedDescription)
      }
    }.resume()
    
  }
  
  func getNumberOfItems() -> Int {
    return items.count
  }
  
  func getItem(at index: Int) -> Item {
    return items[index]
  }
  
  func getTotalCount() -> Int {
    return totalCount
  }
  
  private init(){}
}
