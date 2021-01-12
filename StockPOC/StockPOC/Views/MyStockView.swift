//
//  MyStockView.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/6/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct MyStockView: View {
    @ObservedObject var viewModel = MyStockViewModel()
    var body: some View {
        LoadingView(isShowing: viewModel.isLoading) {
            NavigationView {
                ZStack {
                    VStack (alignment: .leading) {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: SearchSYMView()) {
                                FAText(iconName: "plus", size: 50)
                                    .padding(20)
                            }.navigationBarTitle("Navigation")
                        }
                    }
                }
                .navigationBarTitle("My Stocks")
            }
        }
    }
}

struct MyStockView_Previews: PreviewProvider {
    static var previews: some View {
        MyStockView()
    }
}
