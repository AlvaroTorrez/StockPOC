//
//  MyStockViewCellController.swift
//  StockUIKit
//
//  Created by Alvaro Torrez on 1/18/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit

class MyStockViewCellController: UITableViewCell {
    @IBOutlet weak var symItemLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var stackToTap: UIStackView!
    
    var selectedDelegate: MyStockCellDeleate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEdit))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit() {
        //delegate?.myTableDelegate()
        //print("Test tab" + (symItemLabel?.text)!)
        if let delegate = selectedDelegate {
            delegate.selectedCell(sym: symItemLabel.text ?? "")
        }
    }
    
    func setItem(item: VItemStock) {
        symItemLabel.text = item.sym
        itemNameLabel.text = item.name
    }

    @IBAction func OnRemoveItem(_ sender: Any) {
    }
}

protocol MyStockCellDeleate {
    func selectedCell(sym: String)
}

