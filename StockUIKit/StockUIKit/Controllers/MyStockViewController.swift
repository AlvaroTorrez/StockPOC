//
//  MyStockViewController.swift
//  StockUIKit
//
//  Created by Alvaro Torrez on 1/18/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit

class MyStockViewController: UIViewController {
    
    var stockService: StockServiceProtocol?
    
    var myStockList: [VItemStock] = []
    @IBOutlet weak var myStockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let stockService = DI.shared.resolve(type: StockServiceProtocol.self) else {
            print("An error was appening on resolve DI for StockServiceProtocol")
            return
        }
        
        self.stockService = stockService
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadMyStocksData()
        myStockTableView.reloadData()
    }
    
    func reloadMyStocksData() {
        let myStocks: [MItemStock] = stockService?.getMyStocks() ?? []
        
        myStockList = myStocks.map { (item) -> VItemStock in
            VItemStock(name: item.name, sym: item.symbol)
        }
    }
}

extension MyStockViewController: UITableViewDelegate, UITableViewDataSource, MyStockCellDeleate {
    func removeCell(sym: String) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure to remove this stock", preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default){ (action) in
            self.stockService?.removeStockBySym(sym: sym)
            self.reloadMyStocksData()
            DispatchQueue.main.async {
                self.myStockTableView.reloadData()
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectedCell(sym: String) {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "StockDetail")
        let vc = StockDetailViewController(nibName: "StockDetailViewController", bundle: nil)
        vc.title = sym
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.myStockList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = myStockList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyStockItem") as! MyStockViewCellController
        cell.setItem(item: item)
        cell.selectedDelegate = self
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) : UIColor.white
        return cell
    }
    
    
}
