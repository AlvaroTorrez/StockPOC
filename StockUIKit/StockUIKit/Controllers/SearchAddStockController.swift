//
//  SearchAddStockController.swift
//  StockUIKit
//
//  Created by Alvaro Torrez on 1/13/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit

class SearchAddStockController: UIViewController {
    
    @IBOutlet weak var mainListSearch: UITableView!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var list: [VItemStock] = []
    
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
    
    @IBAction func OnEditingSearch(_ sender: UITextField) {
        
        guard let text = sender.text, !text.isEmpty else {
            CancelSearch()
            return
        }
        
        cancelButton.isHidden = false
        stockService?.searchStockSYM(searchTerm: searchField.text!, completion: { (result) in
            if !result.bestMatches.isEmpty {
                let resultSearch = result.bestMatches.map { (itemResult) -> VItemStock in
                    VItemStock(name: itemResult.name, sym: itemResult.symbol)
                }
                self.list = resultSearch
                DispatchQueue.main.async {
                    self.mainListSearch.reloadData()
                }
            }
        })
    }

    @IBAction func onCancelAddStock(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func OnCancelSearc(_ sender: UIButton) {
        CancelSearch()
    }
    
    func CancelSearch() {
        searchField.text = ""
        cancelButton.isHidden = true
        self.list = [VItemStock]()
        DispatchQueue.main.async {
            self.mainListSearch.reloadData()
        }
    }
    
    @IBAction func OnAddStock(_ sender: Any) {
        guard let index = mainListSearch?.indexPathForSelectedRow?.row else {
            return
        }
        let item = list[index]
        stockService?.saveMyStock(item: MItemStock(symbol: item.sym, name: item.name, currency: ""))
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
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) : UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure to add this stock in your My Stocks", preferredStyle: UIAlertController.Style.alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default){ (action) in
            let item = self.list[indexPath.row]
            self.stockService?.saveMyStock(item: MItemStock(symbol: item.sym, name: item.name, currency: ""))
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}


