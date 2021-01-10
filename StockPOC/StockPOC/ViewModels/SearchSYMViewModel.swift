//
//  SearchSYMViewModel.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/10/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

final class SearchSYMViewModel: BaseViewModel {
    
    let stockService: StockServiceProtocol
    
    @Published var searchTerm = ""
    @Published var searchResult: [ItemResult] {
        willSet { self.objectWillChange.send() }
    }
    
    init (stockService: StockServiceProtocol = DI.shared.resolve(type: StockServiceProtocol.self)!) {
        self.stockService = stockService
        searchResult = [ItemResult]()
        super.init()
    }
    
    func performSearch() {
        stockService.searchStockSYM(searchTerm: searchTerm) { (result) in
            var listSearchResult = [ItemResult]()
            result.bestMatches.forEach { (Item) in
                listSearchResult.append(ItemResult(name: Item.name))
            }
            self.searchResult = listSearchResult
        }
    }
}

struct ItemResult: Identifiable {
    var id = UUID()
    var name: String
}
