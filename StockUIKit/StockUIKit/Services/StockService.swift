//
//  StockService.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/10/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//
import Foundation

final class StockService: StockServiceProtocol {
    
    func searchStockSYM(searchTerm: String, completion: @escaping (SearchSYMResult) -> Void) {
        let parametes = ["function":"SYMBOL_SEARCH",
                         "keywords": searchTerm,
                         "apikey": AppConstants.STOCK_API_KEY]
        RequestApiHelper.getRequest(urlString: EndPoints.QUERY_STOCK_URL, parameters: parametes) { (result: SearchSYMResult) in
            completion(result)
        }
    }
}
