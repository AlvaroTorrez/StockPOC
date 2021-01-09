//
//  MainViewModel.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/7/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import SwiftUI

enum RootViews {
    case Login
    case MyStock
}

final class MainViewModel : BaseViewModel {
    let globalNotificationCenter = NotificationCenter.default
    let authService: AuthServiceProtocol
    
    @Published var currentView: RootViews {
        willSet { self.objectWillChange.send() }
    }
    
    init(authService: AuthServiceProtocol = DI.shared.resolve(type: AuthServiceProtocol.self)!) {
        self.authService = authService
        self.currentView = self.authService.isAuthUser ? .MyStock : .Login
        super.init()
        globalNotificationCenter.addObserver(self, selector: #selector(self.onLoginNotification), name: Notification.Name(NotificationsName.LoginMessage.rawValue), object: nil)
        
        globalNotificationCenter.addObserver(self, selector: #selector(self.onLoginoutNotification), name: Notification.Name(NotificationsName.LoginoutMessage.rawValue), object: nil)
    }
    
    @objc func onLoginNotification() {
        self.currentView = RootViews.MyStock
    }
    
    @objc func onLoginoutNotification() {
        self.currentView = RootViews.Login
    }
}

