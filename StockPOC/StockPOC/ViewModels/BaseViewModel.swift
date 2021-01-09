//
//  BaseViewModel.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/8/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//
import SwiftUI

class BaseViewModel : ObservableObject, Identifiable {
    @Published var isLoading = false
    
    init(){
    }
}
