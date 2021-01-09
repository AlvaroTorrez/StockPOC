//
//  MyStockView.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/6/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

struct MyStockView: View {
    var body: some View {
        NavigationView {
            Text("My Stock view")
            .navigationBarTitle("My Stocks")
        }
    }
}

struct MyStockView_Previews: PreviewProvider {
    static var previews: some View {
        MyStockView()
    }
}
