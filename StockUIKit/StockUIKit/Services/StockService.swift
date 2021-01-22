//
//  StockService.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/10/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//
import Foundation

final class StockService: StockServiceProtocol {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        var temp = [MItemStock]()
        temp.append(MItemStock(symbol: "IBM", name: "IBM Name", currency: "$us"))
        temp.append(MItemStock(symbol: "APPLE", name: "APPLE Name", currency: "$us"))


        if let data = try? PropertyListEncoder().encode(temp) {
            self.userDefaults.set(data, forKey: "MyStocks")
        }
        
    }
    
    func searchStockSYM(searchTerm: String, completion: @escaping (SearchSYMResult) -> Void) {
        let parametes = ["function":"SYMBOL_SEARCH",
                         "keywords": searchTerm,
                         "apikey": AppConstants.STOCK_API_KEY]
        RequestApiHelper.getRequest(urlString: EndPoints.QUERY_STOCK_URL, parameters: parametes) { (result: SearchSYMResult) in
            completion(result)
        }
    }
    
    func getMyStocks() -> [MItemStock] {
        if let data = self.userDefaults.data(forKey: "MyStocks") {
            let array = try! PropertyListDecoder().decode([MItemStock].self, from: data)
            return array
        }
        return [MItemStock]()
    }
    
    func saveMyStock(item: MItemStock) {
        return
    }
}
