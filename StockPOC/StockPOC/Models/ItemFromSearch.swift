//
//  ItemFromSearch.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/9/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

struct ItemFromSearch: Codable {
    var symbol: String
    var name: String
    var currency: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case currency = "8. currency"
    }
}
