//
//  MainView.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/6/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    @ViewBuilder
    var body: some View {
        if viewModel.currentView == .Login {
            LoginView()
        } else if viewModel.currentView == .MyStock{
            MyStockView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
