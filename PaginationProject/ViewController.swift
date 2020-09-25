//
//  ViewController.swift
//  PaginationProject
//
//  Created by Kingsley Enoka on 9/21/20.
//  Copyright © 2020 Kingsley Enoka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tblView: UITableView!
  var page = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    tblView.dataSource = self
    tblView.delegate = self
    getData(page: self.page)
  }
  
  func getData(page: Int) {
    PaginationViewModel.shared.getData(page: page) {
      self.tblView.reloadData()
    }
  }

}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PaginationViewModel.shared.getNumberOfItems()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = PaginationViewModel.shared.getItem(at: indexPath.row).login
    return cell
  }

}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == PaginationViewModel.shared.getNumberOfItems() - 1 {
      if PaginationViewModel.shared.getNumberOfItems() < PaginationViewModel.shared.getTotalCount() {
        page += 1
        self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
      }
    }
  }
  
  @objc func loadTable() {
    getData(page: page)
  }
}
