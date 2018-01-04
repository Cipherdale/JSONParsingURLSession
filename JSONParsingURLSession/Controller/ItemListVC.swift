//
//  ItemListVC.swift
//  JSONParsingURLSession
//
//  Created by Andrian Rahardja on 04/01/18.
//  Copyright © 2018 episquare. All rights reserved.
//

import UIKit

class ItemListVC: UITableViewController {
    
    let itemListCellId = "itemListCellId"
    
    var navTitle: String? {
        didSet {
            guard let title = navTitle else { return }
            navigationItem.title = title
        }
    }
    
    var itemData: [Items]? {
        didSet {
            guard let data = itemData else { return }
            itemData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: itemListCellId)
        
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
}





// MARK: - UITableViewDataSource, UITableViewDelegate
extension ItemListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = itemData?.count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: itemListCellId)
        cell.accessoryType = .disclosureIndicator
        if let data = itemData?[indexPath.row] {
            cell.textLabel?.text = data.itemBrand
            cell.detailTextLabel?.text = data.itemName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let data = itemData?[indexPath.row] {
            let itemDetailVC = ItemDetailVC()
            itemDetailVC.navTitle = "\(data.itemId)"
            itemDetailVC.itemData = data
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(itemDetailVC, animated: true)
            }
        }
    }
    
}
