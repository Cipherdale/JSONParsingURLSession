//
//  MainListVC.swift
//  JSONParsingURLSession
//
//  Created by Andrian Rahardja on 04/01/18.
//  Copyright © 2018 episquare. All rights reserved.
//

import UIKit

class MainListVC: UITableViewController {
    
    let mainListCellId = "mainListCellID"
    var mainList = [MainList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        loadMainList()
    }
    
    
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: mainListCellId)
        
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    
    
    private func loadMainList() {
        
        let hatCategoryUrl = "http://demo9618857.mockable.io/list/hat"
        let jeansCategoryUrl = "http://demo9618857.mockable.io/list/jeans"
        let shirtCategoryUrl = "http://demo9618857.mockable.io/list/shirt"
        
        var hatItems = [Items]()
        var jeansItems = [Items]()
        var shirtItems = [Items]()
        
        let fetchGroup = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        fetchGroup.enter()
        queue.async {
            DataService.shared.getData(urlString: hatCategoryUrl, completion: { (jsonObject) in
                if let object = jsonObject as? [String: Any] {
                    if let value = object["list"] as? [Any] {
                        for item in value {
                            if let itemDictionary = item as? [String: Any] {
                                let item = Items(dictionary: itemDictionary)
                                hatItems.append(item)
                            }
                        }
                        fetchGroup.leave()
                    }
                }
            })
        }
        
        fetchGroup.enter()
        queue.async {
            DataService.shared.getData(urlString: jeansCategoryUrl, completion: { (jsonObject) in
                if let object = jsonObject as? [String: Any] {
                    if let value = object["list"] as? [Any] {
                        for item in value {
                            if let itemDictionary = item as? [String: Any] {
                                let item = Items(dictionary: itemDictionary)
                                jeansItems.append(item)
                            }
                        }
                        fetchGroup.leave()
                    }
                }
            })
        }
        
        fetchGroup.enter()
        queue.async {
            DataService.shared.getData(urlString: shirtCategoryUrl, completion: { (jsonObject) in
                if let object = jsonObject as? [String: Any] {
                    if let value = object["list"] as? [Any] {
                        for item in value {
                            if let itemDictionary = item as? [String: Any] {
                                let item = Items(dictionary: itemDictionary)
                                shirtItems.append(item)
                            }
                        }
                        fetchGroup.leave()
                    }
                }
            })
        }
        
        fetchGroup.notify(queue: queue) {
            
            let hatData = MainList(categoryName: "Hat", categoryItems: hatItems)
            let jeansData = MainList(categoryName: "Jeans", categoryItems: jeansItems)
            let shirtData = MainList(categoryName: "Shirt", categoryItems: shirtItems)
            self.mainList = [hatData, jeansData, shirtData]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}





// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: mainListCellId)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = mainList[indexPath.row].categoryName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let itemListVC = ItemListVC()
        itemListVC.navTitle = mainList[indexPath.row].categoryName
        itemListVC.itemData = mainList[indexPath.row].categoryItems
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(itemListVC, animated: true)
        }
    }
    
}
