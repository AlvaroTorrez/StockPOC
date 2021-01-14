//
//  SearchAddStockController.swift
//  StockUIKit
//
//  Created by William Alvarez on 1/13/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit

class SearchAddStockController: UIViewController {
    
    @IBOutlet weak var mainListSearch: UITableView!
    
    @IBOutlet weak var searchField: UITextField!
    
    var list: [ItemStockSearch] = []
    
    var stockService: StockServiceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let stockService = DI.shared.resolve(type: StockServiceProtocol.self) else {
            print("An error was appening on resolve DI for StockServiceProtocol")
            return
        }
        
        self.stockService = stockService

        // Do any additional setup after loading the view.
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        stockService?.searchStockSYM(searchTerm: searchField.text!, completion: { (result) in
            if result.bestMatches.count > 0 {
                let resultSearch = result.bestMatches.map { (itemResult) -> ItemStockSearch in
                    ItemStockSearch(name: itemResult.name)
                }
                self.list = resultSearch                
                DispatchQueue.main.async {
                    self.mainListSearch.reloadData()
                }
            }
        })
    }
    
}

extension SearchAddStockController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemStockSearch") as! StockSearchedViewCellController
        
        cell.setItem(item: item)
        return cell
    }
}

struct ItemStockSearch: Identifiable {
    var id = UUID()
    
    var name: String
}
