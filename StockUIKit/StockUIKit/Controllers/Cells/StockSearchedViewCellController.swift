//
//  StockSearchedViewCellController.swift
//  StockUIKit
//
//  Created by Alvaro Torrez on 1/13/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit

class StockSearchedViewCellController: UITableViewCell {

    @IBOutlet weak var symLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isCheckIcon: UIImageView!
    
    var isSelectedCell: Bool {
        get {
            return isCheckIcon.isHidden
        }
        set {
            isCheckIcon.isHidden = !newValue
        }
    }
    
    func setItem(item: VItemStock) {
        nameLabel.text = item.name
        symLabel.text = item.sym
    }
    
    

}
