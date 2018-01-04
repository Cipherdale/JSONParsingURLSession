//
//  ItemDetailVC.swift
//  JSONParsingURLSession
//
//  Created by Andrian Rahardja on 04/01/18.
//  Copyright © 2018 episquare. All rights reserved.
//

import UIKit

class ItemDetailVC: UITableViewController {
    
    let itemDetailCellId = "itemDetailCellId"
    
    var navTitle: String? {
        didSet {
            guard let title = navTitle else { return }
            navigationItem.title = title
        }
    }
    
    var itemData: Items?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    
    private func setupTableView() {
        tableView.register(ItemDetailCell.self, forCellReuseIdentifier: itemDetailCellId)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
}





// MARK: - UITableViewDataSource, UITableViewDelegate
extension ItemDetailVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemDetailCellId, for: indexPath) as! ItemDetailCell
        cell.itemData = itemData
        return cell
    }
    
}
