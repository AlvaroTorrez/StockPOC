//
//  StockServiceProtocol.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/10/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

protocol StockServiceProtocol {
    
    func searchStockSYM(searchTerm: String, completion: @escaping (SearchSYMResult) -> Void)
}
