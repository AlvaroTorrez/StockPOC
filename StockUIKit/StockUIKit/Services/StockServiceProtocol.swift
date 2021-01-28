//
//  StockServiceProtocol.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/10/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import Foundation

protocol StockServiceProtocol {
    
    func searchStockSYM(searchTerm: String, completion: @escaping (SearchSYMResult) -> Void)
    
    func getMyStocks() -> [MItemStock]
    
    func saveMyStock(item: MItemStock) -> Void
    
    func removeStockBySym(sym: String) -> Void
}
