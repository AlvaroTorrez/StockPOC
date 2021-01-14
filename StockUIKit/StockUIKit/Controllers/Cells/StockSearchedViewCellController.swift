//
//  StockSearchedViewCellController.swift
//  StockUIKit
//
//  Created by William Alvarez on 1/13/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit

class StockSearchedViewCellController: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    
    func setItem(item: ItemStockSearch) {
        itemName.text = item.name
    }

}
