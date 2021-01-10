//
//  SearchSYMView.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/10/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

struct SearchSYMView: View {
    @ObservedObject var viewModel = SearchSYMViewModel()
    var body: some View {
        LoadingView(isShowing: viewModel.isLoading) {
            VStack {
                TextField("Search", text: self.$viewModel.searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    self.viewModel.performSearch()
                }){
                    Text("Search")
                        .fontWeight(.bold)
                        .font(.body)
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                List (self.viewModel.searchResult) { item in
                    Text(item.name)
                }
            }
        }
    }
}

struct SearchSYMView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSYMView()
    }
}
