//
//  LoginViewModel.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/6/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

final class LoginViewModel : BaseViewModel {
    
    let authService: AuthServiceProtocol
    @Published var username = ""
    @Published var password = ""
    
    @Published var isLoggedIn = false
    @Published var showError = false
    
    init(authService: AuthServiceProtocol = DI.shared.resolve(type: AuthServiceProtocol.self)!) {
        self.authService = authService
        super.init()
    }
    
    func performAuthUser() {
        isLoading = true
        authService.authUser(username: username, password: password) { (status) in
            self.isLoading = false
            if status == .SUCCESS {
                self.showError = false
                let globalNotificationCenter = NotificationCenter.default
                globalNotificationCenter.post(name: Notification.Name(NotificationsName.LoginMessage.rawValue), object: nil)
            } else {
                self.showError = true
            }
        }
    }

}
