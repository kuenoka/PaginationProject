//
//  PaginationModel.swift
//  PaginationProject
//
//  Created by Kingsley Enoka on 9/21/20.
//  Copyright © 2020 Kingsley Enoka. All rights reserved.
//

import Foundation

struct PaginationModel: Codable {
  var items: [Item]
  var total_count: Int
}

struct Item: Codable {
  var login: String
}
