//
//  LoginView.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/6/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    @State var mainView = false
    
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        LoadingView(isShowing: viewModel.isLoading) {
            NavigationView {
                VStack {
                    NavigationLink(destination: MyStockView().navigationBarBackButtonHidden(true), isActive: self.$mainView) {
                        EmptyView()
                    }
                    Spacer()
                    Text("Stock POC")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    TextField("Username", text: self.$viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                    SecureField("Password", text: self.$viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                    Button(action: {
                        self.viewModel.performAuthUser()
                        self.hideKeyboard()
                    }){
                        Text("Login")
                            .fontWeight(.bold)
                            .font(.body)
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                    Spacer()
                }
                .padding()
                .padding(.bottom, self.keyboardHeight)
                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
